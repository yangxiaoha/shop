package com.zpt.shop.main.entities;

import java.math.BigDecimal;

/**
 * 功能说明:
 *
 * Distribution.java
 *
 * Original Author: 林敏,2016年12月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class Distribution {
	
	private Integer id;
	
	private Integer userId;//用户id
	
	private Integer orderId;//订单id
	
	private String money;//提成金额
	
	private String openid;
	
	private String name;
	
	private String ordernum;
	
	private BigDecimal totalprice;
	
	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public BigDecimal getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

}