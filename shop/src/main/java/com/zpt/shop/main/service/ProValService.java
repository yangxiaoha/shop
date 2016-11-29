package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.ProVal;

/**
 * 功能说明:
 *
 * ProValService.java
 *
 * Original Author: 林敏,2016年11月22日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface ProValService {

	/**
	 * 通过商品类型id查找商品属性
	 * @param Integer typeId
	 * */
	List<ProVal> getProByTypeId(Integer goodsId);

}