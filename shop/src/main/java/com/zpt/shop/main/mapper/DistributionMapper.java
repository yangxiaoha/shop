package com.zpt.shop.main.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.Distribution;

/**
 * 功能说明:
 *
 * DistributionMapper.java
 *
 * Original Author: 林敏,2016年12月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface DistributionMapper {

	public void addDistribution(@Param("userId")Integer userId, @Param("orderId")Integer orderId, @Param("money")BigDecimal money);

	public List<Distribution> seeWithdraw(@Param("userId")Integer userId);
}