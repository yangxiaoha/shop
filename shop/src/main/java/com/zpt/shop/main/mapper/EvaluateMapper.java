package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
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
	
	public List<Evaluate> listEvaluate(Query<Evaluate> query);
	
	public Integer countEvaluate(Query<Evaluate> query);
	
	public void deleteEvaluate(@Param("ids")String ids);

	public void addEvaluate(Evaluate evaluate);

	public List<Evaluate> getEvaluateByUserId(@Param("userId")Integer userId);

	public List<Evaluate> getEvaluateByGoodsId(@Param("goodsId")Integer goodsId);

	public Evaluate getEvaluate(@Param("orderId")Integer orderId, @Param("skuId")Integer skuId, @Param("userId")Integer userId);

}