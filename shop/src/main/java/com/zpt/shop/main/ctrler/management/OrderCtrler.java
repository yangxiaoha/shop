package com.zpt.shop.main.ctrler.management;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
				message.setUrl("http://weixin.591yjx.com/shop/home/purchase/orderDetail");
	
				message.getData().put("first", new WxMpTemplateData("喜事正在赶来\n您好，你的一见喜已经发出，请及时查收！"));
				message.getData().put("keyword1", new WxMpTemplateData(order.getLogistics()+""));
			
				message.getData().put("keyword2", new WxMpTemplateData(order.getLogisticsnum()+""));
				message.getData().put("keyword3", new WxMpTemplateData(order.getGoodsnames()+""));
				message.getData().put("keyword4", new WxMpTemplateData(order.getNums()+"件\n"));
		
				message.getData().put("remark", new WxMpTemplateData("人生一见喜，一床有阳光味道的新疆棉花被，喜事开启！","#FF0000"));
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
