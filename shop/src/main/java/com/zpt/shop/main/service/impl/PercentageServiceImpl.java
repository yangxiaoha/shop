package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Percentage;
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

	@Override
	public Page<Percentage> page(Query<Percentage> query) {
		// TODO Auto-generated method stub
		Page<Percentage> page = new Page<>();
		List<Percentage> list = percentageMapper.listPercentage(query);
		Integer count = percentageMapper.countPercentage(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());		
		return page;
	}

	@Override
	public void updatePercentage(Percentage percentage) {
		// TODO Auto-generated method stub
		percentageMapper.updatePercentage(percentage);
	}

}