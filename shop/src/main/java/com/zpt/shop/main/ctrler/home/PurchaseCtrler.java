package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.weaver.ast.Var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.service.CartService;

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
	
	//添加购物车
	@ResponseBody
	@RequestMapping(value="/placeOrder", method=RequestMethod.POST)
	public Map<String,Object> placeOrder(String skuId, String num, String price) {
		Map<String,Object> map = new HashMap<String, Object>();
		String userId = "1";//先设置用户为1
		Integer amount = cartService.addGoodsIntoCart(userId, skuId, num, price);
		map.put("state", true);
		map.put("amount", amount);
		return map;
	}
	
	//立即购买
	@RequestMapping(value="/buyImmediately/{skuId}/{num}/{price}", method=RequestMethod.POST)
	public ModelAndView buyImmediately(@PathVariable("skuId")Integer skuId, @PathVariable("num")Integer num, @PathVariable("price")String price) {
		ModelAndView mv = new ModelAndView("home/index");
		return mv;
	}
	
	//购物车页面
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public ModelAndView cart() {
		ModelAndView mv = new ModelAndView("home/cart");
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.00d;
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
	
	//删除购物车里的商品
	@ResponseBody
	@RequestMapping(value="/deleteGoods", method=RequestMethod.POST)
	public Map<String,Object> deleteGoods(String cartId) {
		Map<String,Object> map = new HashMap<String, Object>();
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.00d;
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
}