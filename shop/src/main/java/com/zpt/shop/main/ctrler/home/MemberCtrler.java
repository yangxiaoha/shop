package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.weixin.WeixinUserInfo;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WithdrawService;
import com.zpt.shop.weixin.utils.WeixinUtils;

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
	public ModelAndView memberCenter(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("home/member-center");
		//获取用户信息
		User user = (User) request.getSession().getAttribute("user");
		//获取OAuth2.0请求后，服务器返回的code内容
		String code = request.getParameter("code");
		String accessToken = WeixinUtils.getAuthAccessToken(code);
		//是否有上级
		if(!("0".equals(user.getPid()))) {
			User superiorUser = userService.getUserId(user.getPid());
			WeixinUserInfo superiorUserInfo = WeixinUtils.getWeixinUserInfo(accessToken, superiorUser.getOpenid());
			mv.addObject("superiorName", superiorUserInfo.getNickname());//用户上级昵称
		}		
        //获取用户微信信息（传入accessToken和openId获取用户信息）        
        WeixinUserInfo userInfo = WeixinUtils.getWeixinUserInfo(accessToken, user.getOpenid()); 
        mv.addObject("superiorName", "一见喜");//用户上级昵称
		mv.addObject("name", userInfo.getNickname());//用户昵称
		mv.addObject("headImg", userInfo.getHeadImgUrl());//用户头像
        //用户上级、可提现金额、已提现金额
		BigDecimal totalPrice = new BigDecimal("0.0");		
		List<Withdraw> withdrawList = withdrawService.getMemberInfo(user.getId());
		if(withdrawList != null && withdrawList.size() > 0) {
			for(int i=0; i<withdrawList.size(); i++) {
				BigDecimal price = new BigDecimal(withdrawList.get(i).getCashMoney());
				totalPrice = totalPrice.add(price);
			}
			mv.addObject("totalPrice", totalPrice);
		}else {
			mv.addObject("totalPrice", "0.00");
		}
		//代理人信息
		List<User> userList = userService.getAgentInfoByMyId(user.getId());
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
		mv.addObject("withdrawsMsg", withdrawsList);
		return mv;
	}
	
	//提现
	@ResponseBody
	@RequestMapping(value="/withdrawalsApply", method=RequestMethod.POST)
	public Map<String,Object> withdrawalsApply(String money) {
		Map<String,Object> map = new HashMap<String, Object>();
		Integer userId = 1;//先设置用户为1
		//提现申请
		List<Withdraw> withdrawsList = withdrawService.addWithdrawsInfo(userId, money);
		map.put("state", true);
		map.put("withdrawsMsg", withdrawsList);
		return map;
	}

}