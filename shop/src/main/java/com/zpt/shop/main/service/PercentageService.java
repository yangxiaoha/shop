package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Percentage;
/**
 * 功能说明:
 * 
 * 分销百分比
 *
 * PercentageService.java
 *
 * Original Author: 林敏,2016年12月21日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface PercentageService {
	
	public Page<Percentage> page(Query<Percentage> query);
	
	public void updatePercentage(Percentage percentage);

	public Percentage getPercentage();

}