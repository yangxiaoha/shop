package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Percentage;

/**
 * 功能说明:
 *
 * PercentageMapper.java
 *
 * Original Author: 林敏,2016年12月21日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface PercentageMapper {
	
	public List<Percentage> listPercentage(Query<Percentage> query);
	
	public Integer countPercentage(Query<Percentage> query);
	
	public void updatePercentage(Percentage percentage);

	public Percentage getPercentage();

}