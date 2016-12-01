package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.service.CartService;
import com.zpt.shop.main.service.OrderDetailService;
import com.zpt.shop.main.service.OrderService;

/**
 * 功能说明:
 *
 * PurchaseCtrler.java
 *
 * Original Author: 林敏,2016年11月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/purchase")
public class PurchaseCtrler {
	
	private static Logger logger = LogManager.getLogger(PurchaseCtrler.class.getName());
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	//购物车页面
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public ModelAndView cart() {
		ModelAndView mv = new ModelAndView("home/cart");
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.getCartInfo(userId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00");  
			mv.addObject("totalNum", totalNum);
			mv.addObject("total", df.format(total));
			mv.addObject("cartsMsg", cartsList);	
		}else {
			mv.addObject("totalNum", "0");
			mv.addObject("total", "0.00");
			mv.addObject("cartsMsg", null);
		}
		return mv;
	}
	
	//添加购物车
	@ResponseBody
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public Map<String,Object> addCart(String skuId, Integer num, String price) {
		Map<String,Object> map = new HashMap<String, Object>();
		String userId = "1";//先设置用户为1
		Integer amount = cartService.addGoodsIntoCart(userId, skuId, num, price);
		map.put("state", true);
		map.put("amount", amount);
		return map;
	}
	
	//删除购物车里的商品
	@ResponseBody
	@RequestMapping(value="/deleteGoods", method=RequestMethod.POST)
	public Map<String,Object> deleteGoods(String cartId) {
		Map<String,Object> map = new HashMap<String, Object>();
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.deleteCartInfo(userId, cartId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00");  
			map.put("state", true);
			map.put("totalNum", totalNum);
			map.put("total", df.format(total));
			map.put("cartsMsg", cartsList);
		}else {
			map.put("state", true);
			map.put("totalNum", "0");
			map.put("total", "0.00");
			map.put("cartsMsg", null);
		}
		return map;
	}
	
	//修改购物车
	@ResponseBody
	@RequestMapping(value="/modifyCart", method=RequestMethod.POST)
	public Map<String,Object> modifyCart(String cartId, String skuId, Integer goodsNum, String goodsPrice) {
		Map<String,Object> map = new HashMap<String, Object>();
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.modifyGoodsIntoCart(userId, cartId, skuId, goodsNum, goodsPrice);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00"); 
			map.put("state", true);
			map.put("totalNum", totalNum);
			map.put("total", df.format(total));
			map.put("cartsMsg", cartsList);	
		}else {
			map.put("state", true);
			map.put("totalNum", "0");
			map.put("total", "0.00");
			map.put("cartsMsg", null);
		}
		return map;
	}
	
	//立即购买
	@RequestMapping(value="/buyImmediately/{skuId}/{num}/{price}", method=RequestMethod.POST)
	public ModelAndView buyImmediately(@PathVariable("skuId")Integer skuId, @PathVariable("num")Integer num, @PathVariable("price")String price) {
		ModelAndView mv = new ModelAndView("home/index");
		return mv;
	}
	
	//结算（从购物车过来的购买）
	@RequestMapping(value="/buyGoods", method=RequestMethod.POST)
	public ModelAndView buyGoods(String cartIds) {
		ModelAndView mv = new ModelAndView("home/order");
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.getCartByCartIds(userId, cartIds);
		for(int i=0; i<cartsList.size(); i++) {
			num = cartsList.get(i).getNum();
			price = cartsList.get(i).getPrice();
			totalPrice = price.multiply(new BigDecimal(num));
			total = totalPrice.add(new BigDecimal(total)).doubleValue();
		}
		DecimalFormat df = new DecimalFormat("#.00");
		mv.addObject("cartIds", cartIds);
		mv.addObject("total", df.format(total));
		mv.addObject("cartsMsg", cartsList);	
		return mv;
	}
	
	//支付（从详细页过来的支付）
	@RequestMapping(value="/payment/{orderId}", method=RequestMethod.GET)
	public ModelAndView payment(@PathVariable("orderId")Integer orderId) {
		ModelAndView mv = new ModelAndView("home/order-payment");
		List<Order> orderList = orderService.getOrderByOrderId(orderId);
		mv.addObject("orderId", orderId);
		mv.addObject("orderMsg", orderList);	
		return mv;
	}
	
	//我的地址
	@RequestMapping(value="/myAddr", method=RequestMethod.GET)
	public ModelAndView myAddr() {
		ModelAndView mv = new ModelAndView("home/my-addr");
		
		return mv;
	}
	
	//提交订单
	//若未付款，跳到订单详细页
	@RequestMapping(value="/submitOrder", method=RequestMethod.POST)
	public ModelAndView submitOrder(String postData, String cartIds, String state) {
		ModelAndView mv = new ModelAndView("home/order-detail");		
		Integer userId = 1;//先设置用户为1
		if("0".equals(state)) {//从我的订单过来的付款			
			//添加订单
			Order order = (Order) JSON.parseObject(postData, Order.class);
			orderService.addOrder(userId, order, cartIds);
		}else if("1".equals(state)) {//从购物车过来的付款
			
		}
		//查询订单详情
		List<Order> orderList = orderService.getOrderDetail(userId);
		mv.addObject("orderMsg", orderList);
		return mv;
	}
	
	//订单详细页
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public ModelAndView orderDetail() {
		ModelAndView mv = new ModelAndView("home/order-detail");			
		Integer userId = 1;//先设置用户为1
		//查询订单详情
		List<Order> orderList = orderService.getOrderDetail(userId);
		mv.addObject("orderMsg", orderList);
		return mv;
	}
	
}