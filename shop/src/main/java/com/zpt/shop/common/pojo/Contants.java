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
	
	//添加
	public static final String ADD_SUCCESS = "添加成功";
	public static final String ADD_LOST = "添加失败";
	
	//删除
	public static final String DELETE_SUCCESS = "删除成功";
	public static final String DELTET_LOST = "删除失败";
	
	//修改
	public static final String UPDATE_SUCCESS = "修改成功";
	public static final String UPDATE_LOST = "修改失败";	
	
	//置顶
	public  static final String ADD_GOODS_STICK = "置顶成功";
	public  static final String DOWN_GOODS_STICK = "取消置顶成功";
	public  static final String MSG_GOODS_STICK = "置顶失败，请重试！";
	public  static final String MSG_GOODS_DOWN = "取消置顶失败，请重试！";
	
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
		
	//充值成功
	public static final String RETURN_SPREAD_SUCCESS = "充值成功";

	//openid
	public static String SESSION_OPENID = "openid";
	/**
	 *微信消息模板ID
	 *来自微信公众平台-模板消息
	 *
	 *
	 */
	public static final String WX_ORDER_SEND = "yXyRVvwrDSXnZGkMxZM4Z4AFzSg7C3nsB3mOhfBz0G4";
}
