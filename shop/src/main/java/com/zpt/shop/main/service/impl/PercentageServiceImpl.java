package com.zpt.shop.main.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Percentage;
import com.zpt.shop.main.mapper.BrandMapper;
import com.zpt.shop.main.mapper.PercentageMapper;
import com.zpt.shop.main.service.PercentageService;

/**
 * 功能说明:
 *
 * PercentageServiceImpl.java
 *
 * Original Author: 林敏,2016年12月21日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Service
public class PercentageServiceImpl implements PercentageService {
	
	@Autowired
	private PercentageMapper percentageMapper;

	@Override
	public Percentage getPercentage() {
		// TODO Auto-generated method stub
		Percentage percentage = percentageMapper.getPercentage();
		return percentage;
	}

}