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
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.service.OrderDetailService;
import com.zpt.shop.main.service.OrderService;

@Controller
@RequestMapping("/management/order")
public class OrderCtrler {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private OrderDetailService orderDetailService;
	
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
	
	@ResponseBody
	@RequestMapping(value = "/updateStateS",method = RequestMethod.POST)
	public Msg update(Order order){
		Msg msg = new Msg();
		try {
			orderService.updateState(order);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
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
