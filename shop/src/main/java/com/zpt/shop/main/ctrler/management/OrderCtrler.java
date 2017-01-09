package com.zpt.shop.main.ctrler.management;

import java.util.List;

import org.aspectj.apache.bcel.classfile.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opensymphony.module.sitemesh.mapper.OSDecoratorMapper;
import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.common.weixin.WxMpTemplateData;
import com.zpt.shop.common.weixin.WxMpTemplateMessage;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.OrderDetailService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WxMpService;


@Controller
@RequestMapping("/management/order")
public class OrderCtrler {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private WxMpService wxService;
	@Autowired
	private UserService uService;
	
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/order/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Order> listData(Query<Order> query){
		Page<Order> page = orderService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Order order){
		boolean flag = false;
		try {
			flag = orderService.validate(order);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "getOrderDetail", method = RequestMethod.POST)
	public List<OrderDetail> orderDetail(Integer orderId){
		List<OrderDetail> list = null;
		try {
			list = orderDetailService.getAllOrderDetail(orderId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;		
	}
	
	/**
	 * 订单发货
	 * @param order
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStateS",method = RequestMethod.POST)
	public Msg update(Order order){
		Msg msg = new Msg();
		try {
			orderService.updateState(order);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			WxMpTemplateMessage message = new WxMpTemplateMessage();

			User u=uService.getUserByUserId(orderService.getOrderByOrderId(order.getId()).get(0).getUserId());
			String openid = u.getOpenid();
			System.out.println(openid + "openid------");
			if (openid != null) {
				message.setTouser(openid);
				message.setTopcolor("#FF0000");
				message.setTemplate_id(Contants.WX_ORDER_SEND);
				//跳转到订单详情
				message.setUrl("");
	
				message.getData().put("first", new WxMpTemplateData("您好，收到新的物流消息"));
				message.getData().put("OrderSn",
						new WxMpTemplateData(order.getId()+""));
			
				message.getData().put("OrderStatus", new WxMpTemplateData("已发货"));
		
				message.getData().put("remark", new WxMpTemplateData("\n做一床有阳光味道的新疆棉被，一见欢喜 \n点击查看详情"));
				String re = wxService.templateSend(message);
				System.err.println("result---" + re);
			}
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);			
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/see",method = RequestMethod.POST)
	public Msg see(Order order){
		Msg msg = new Msg();
		try {
			orderService.seeOrder(order);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg("");
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);			
			return msg;
		}
	}
}
