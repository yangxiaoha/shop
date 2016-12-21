package com.zpt.shop.main.entities;

import java.math.BigDecimal;

/**
 * 功能说明:
 *
 * Percentage.java
 *
 * Original Author: 林敏,2016年12月21日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class Percentage {
	
	private Integer id;
	
	//一级百分比
	private BigDecimal first;
	
	//二级百分比
	private BigDecimal second;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getFirst() {
		return first;
	}

	public void setFirst(BigDecimal first) {
		this.first = first;
	}

	public BigDecimal getSecond() {
		return second;
	}

	public void setSecond(BigDecimal second) {
		this.second = second;
	}

}