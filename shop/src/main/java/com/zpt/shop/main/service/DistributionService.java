package com.zpt.shop.main.service;

import java.math.BigDecimal;
import java.util.List;

import com.zpt.shop.main.entities.Distribution;

/**
 * 功能说明:
 *
 * DistributionService.java
 *
 * Original Author: 林敏,2016年12月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface DistributionService {

	/**
	 * 添加分销信息
	 * @param Integer userId
	 * @param Integer orderId
	 * @param BigDecimal money
	 * */
	public void addDistribution(Integer userId, Integer orderId, BigDecimal money);
	
	public List<Distribution> seeWithdraw(Integer userId);

}