package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 功能说明:
 *
 * Withdraw.java
 *
 * Original Author: 林敏,2016年12月1日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class Withdraw {
	
	private Integer id;
	
	//提现人员
	private Integer userId;
	
	//提现时间
	private Date cashTime;
	
	//提现编号
	private String cashNum;
	
	//提现金额
	private BigDecimal cashMoney;
	
	//提现状态
	private Integer state;
	
	private User user;	
	
	private String username;

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
	
	public String getCashNum() {
		return cashNum;
	}

	public void setCashNum(String cashNum) {
		this.cashNum = cashNum;
	}

	public String getCashTime() {
		if(this.cashTime != null){
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(this.cashTime);
		}else{
			return "";
		}
	}

	public void setCashTime(Date cashTime) {
		this.cashTime = cashTime;
	}

	public String getCashMoney() {
		return cashMoney.toString();
	}

	public void setCashMoney(BigDecimal cashMoney) {
		this.cashMoney = cashMoney;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	

}