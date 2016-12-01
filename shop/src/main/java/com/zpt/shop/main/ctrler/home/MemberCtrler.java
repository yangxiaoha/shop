package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashSet;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.mapper.OrderMapper;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WithdrawService;

/**
 * 功能说明:
 *
 * MemberCtrler.java
 *
 * Original Author: 林敏,2016年11月7日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/member")
public class MemberCtrler {
	
	private static Logger logger = LogManager.getLogger(MemberCtrler.class.getName());
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WithdrawService withdrawService;
	
	//会员中心
	@RequestMapping(value="/memberCenter", method=RequestMethod.GET)
	public ModelAndView memberCenter() {
		ModelAndView mv = new ModelAndView("home/member-center");
		Integer userId = 1;//先设置用户为1
		//用户上级、可提现金额、已提现金额
		BigDecimal price = new BigDecimal("0.0");
		BigDecimal totalPrice = new BigDecimal("0.0");
		User user = userService.getUserId(userId);
		List<Withdraw> withdrawList = withdrawService.getMemberInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0) {
			for(int i=0; i<withdrawList.size(); i++) {
				price = withdrawList.get(i).getCashMoney();
				totalPrice = totalPrice.add(price);
			}
			mv.addObject("totalPrice", totalPrice);
		}else {
			mv.addObject("totalPrice", "0.00");
		}
		//代理人信息
		List<User> userList = userService.getAgentInfoByMyId(userId);
		String primary = "";//一级分销
		String second = "";//二级分销
		String ids = "";//分销
		int num = 0;
		BigDecimal payPrice = new BigDecimal("0.00");//下单购买金额
		BigDecimal noPayPrice = new BigDecimal("0.00");//下单未购买金额
		if(userList != null && userList.size() > 0) {
			for(int i=0; i<userList.size(); i++) {
				if(primary != null && !("".equals(primary))) {
					primary = primary + "," + userList.get(i).getId();
				}else {
					primary = userList.get(i).getId().toString();
				}
				if(userList.get(i).getPid() != null && !("".equals(userList.get(i).getPid()))) {
					if(second != null && !("".equals(second))) {
						second = second + "," + userList.get(i).getPid();
					}else {
						second = userList.get(i).getPid().toString();
					}
				}
			}
			if(second != null && !("".equals(second))) {
				ids = primary + "," + second;
			}
			String[] strArray = null;   
	        strArray = ids.split(","); //拆分字符为"," ,然后把结果交给数组strArray 
	        HashSet<String> h = new HashSet<String>();
	        for(int i = 0; i<strArray.length; i++) {
	        	h.add(strArray[i]);
	        }
			//下单已购买
			List<Order> orderPayList = orderService.getOrderInfoByPay(ids);
			//下单未购买
			List<Order> orderNoPayList = orderService.getOrderInfoByNoPay(ids);
			if(orderPayList != null && orderPayList.size() > 0) {
				for(int i=0; i<orderPayList.size(); i++) {
					payPrice = payPrice.add(orderPayList.get(i).getTotalPrice());
					num++;
				}
				mv.addObject("payNum", orderPayList.size());//下单支付订单数量
			}else {
				mv.addObject("payNum", "0");//下单支付订单数量
			}
			if(orderNoPayList != null && orderNoPayList.size() > 0) {
				for(int i=0; i<orderNoPayList.size(); i++) {
					noPayPrice = noPayPrice.add(orderNoPayList.get(i).getTotalPrice());
					num++;
				}
				mv.addObject("noPayNum", orderNoPayList.size());//下单未支付订单数量
			}else {
				mv.addObject("noPayNum", "0");//下单未支付订单数量
			}
			mv.addObject("peopleNum", h.size());//代理人数
			mv.addObject("num", num);//订单总数
			mv.addObject("payPrice", payPrice);//下单支付金额
			mv.addObject("noPayPrice", noPayPrice);//下单未支付金额
			mv.addObject("price", payPrice.add(noPayPrice));//总金额
		}else {
			mv.addObject("peopleNum", "0");//代理人数			
			mv.addObject("payNum", "0");//下单支付订单数量
			mv.addObject("noPayNum", "0");//下单未支付订单数量
			mv.addObject("num", "0");//订单总数
			mv.addObject("payPrice", "0.00");//下单支付金额
			mv.addObject("noPayPrice", "0.00");//下单未支付金额
			mv.addObject("price", "0.00");//总金额
		}		
		mv.addObject("userMsg", user);
		mv.addObject("withdrawMsg", withdrawList);
		return mv;
	}
	
	//提现
	@RequestMapping(value="/withdrawals", method=RequestMethod.GET)
	public ModelAndView withdrawals() {
		ModelAndView mv = new ModelAndView("home/withdrawals");
		Integer userId = 1;//先设置用户为1
		List<Withdraw> withdrawsList = withdrawService.getWithdrawsInfo(userId);
		mv.addObject("withdrawsMsg", withdrawsList);//总金额
		return mv;
	}

}