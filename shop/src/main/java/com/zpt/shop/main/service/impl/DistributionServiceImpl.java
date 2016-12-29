package com.zpt.shop.main.service.impl;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.mapper.DistributionMapper;
import com.zpt.shop.main.service.DistributionService;

/**
 * 功能说明:
 *
 * DistributionServiceImpl.java
 *
 * Original Author: 林敏,2016年12月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Service
public class DistributionServiceImpl implements DistributionService {
	
	@Autowired
	private DistributionMapper distributionMapper;

	@Override
	public void addDistribution(Integer userId, Integer orderId, BigDecimal money) {
		// TODO Auto-generated method stub
		distributionMapper.addDistribution(userId, orderId, money);
	}

}