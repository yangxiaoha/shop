package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.Evaluate;

/**
 * 功能说明:
 *
 * EvaluateMapper.java
 *
 * Original Author: 林敏,2017年1月13日
 *
 * Copyright (C)2014－2017 智平台.All rights reserved. 
 */
public interface EvaluateMapper {

	public void addEvaluate(Evaluate evaluate);

	public List<Evaluate> getEvaluateByUserId(@Param("userId")Integer userId);

	public List<Evaluate> getEvaluateByGoodsId(@Param("goodsId")Integer goodsId);

}