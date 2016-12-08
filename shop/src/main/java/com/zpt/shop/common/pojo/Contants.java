package com.zpt.shop.common.pojo;
/**
 * 功能说明:
 *
 * Contants.java
 *
 * Original Author: 林敏,2016年5月16日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public final class Contants {
	
	//重定向前缀
	public static final String REDIRECT = "redirect:";
	
	//登录错误
	public static final String MSG_LOGIN_FAIL = "用户名或者密码错误";
	
	//供应商	
	public static final Long SUPPLIER_ID = 2l;
	public static final String SUPPLIER_NAME = "供应商";
	public static final String ADD_SUPPLIER_NAME = "添加供应商成功";
	
	//品牌
	public static final String ADD_BRAND_NAME = "添加品牌成功";
	
	//品牌
	public static final String ADD_GOODS_NAME = "添加商品成功";
	public static final String MSG_GOODS_NAME = "添加商品失败，请重试！";
	
	//置顶
	public  static final String ADD_GOODS_STICK = "置顶成功";
	public  static final String MSG_GOODS_STICK = "置顶失败，请重试！";
	
	//状态存在
	public static final Integer STATE_IN = 1;
	
	//状态删除
	public static final Integer STATE_OUT = 0;
	
	//返回状态整型状态成功
	public static final Integer RETURN_INT_SUCCESS = 1;
	
	//返回状态整型状态失败
	public static final Integer RETURN_INT_FAIL = 0;
	
	//异常返回消息
	public static final String RETURN_STRING_EXCEPTION_FAIL = "系统故障，请稍后重试";
	
	//成功消息
	public static final String RETURN_STRING_SUCCESS = "成功";
	
	//充值成功
	public static final String RETURN_SPREAD_SUCCESS = "充值成功";
	
	//试卷购买失败
	public static final String RETURN_PURCHASE_SUCCESS = "余额不足";
}
