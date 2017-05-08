
package com.zpt.shop.common.pojo;
/**
 * 功能说明:
 *
 * Msg.java
 *
 * Original Author: 刘腾达,2016年5月22日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class Msg {
	
	//返回goodsid
	private Integer goodsId;

	//返回状态
	private Integer state;
	
	//返回消息
	private String msg;
	
	//支付返回消息
	private String code_des;
	
	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode_des() {
		return code_des;
	}

	public void setCode_des(String code_des) {
		this.code_des = code_des;
	}
	
}
