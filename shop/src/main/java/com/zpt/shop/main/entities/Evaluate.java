package com.zpt.shop.main.entities;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Evaluate {
	
	private Integer id;
	
	private Integer orderId;
	
	private Integer skuId;
	
	private Integer userId;
	
	private String evaluate;
	
	private Date evaluateTime;
	
	private String val;
	
	private String name;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getSkuId() {
		return skuId;
	}

	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getEvaluate() {
		return evaluate;
	}

	public void setEvaluate(String evaluate) {
		this.evaluate = evaluate;
	}

	public String getEvaluateTime() {
		if(this.evaluateTime != null){
			return new SimpleDateFormat("yyyy/MM/dd").format(this.evaluateTime);
		}else{
			return "";
		}
	}

	public void setEvaluateTime(Date evaluateTime) {
		this.evaluateTime = evaluateTime;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
