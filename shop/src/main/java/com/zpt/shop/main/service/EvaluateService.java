package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Evaluate;
import com.zpt.shop.main.entities.Order;

/**
 * 功能说明:
 *
 * EvaluateService.java
 *
 * Original Author: 林敏,2017年1月13日
 *
 * Copyright (C)2014－2017 智平台.All rights reserved. 
 */
public interface EvaluateService {
	
	public Page<Evaluate> page(Query<Evaluate> query);
	
	public void deleteEvaluate(String ids);
	
	public List<Order> seeOrderAll(Integer orderId);

	public void addEvaluate(Integer orderId, Integer skuId, Integer id, String evaluate);

	public List<Evaluate> getEvaluateByUserId(Integer userId);

	/**
	 * 查询评论
	 * */
	public List<Evaluate> getEvaluateByGoodsId(Integer goodsId);

	/**
	 * 查询评论
	 * */
	public Evaluate getEvaluate(Integer orderId, Integer skuId, Integer userId);
	
}