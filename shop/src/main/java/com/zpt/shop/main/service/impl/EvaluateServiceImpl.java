package com.zpt.shop.main.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Evaluate;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.mapper.EvaluateMapper;
import com.zpt.shop.main.service.EvaluateService;

/**
 * 功能说明:
 *
 * EvaluateServiceImpl.java
 *
 * Original Author: 林敏,2017年1月13日
 *
 * Copyright (C)2014－2017 智平台.All rights reserved. 
 */
@Service
public class EvaluateServiceImpl implements EvaluateService {
	
	@Autowired
	private EvaluateMapper evaluateMapper;

	@Override
	public void addEvaluate(Integer orderId, Integer skuId, Integer userId, String content) {
		// TODO Auto-generated method stub
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
		Date evaluateTime = new Date();
		try {
			evaluateTime = df.parse(df.format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Evaluate evaluate = new Evaluate();
		evaluate.setOrderId(orderId);
		evaluate.setSkuId(skuId);
		evaluate.setUserId(userId);
		evaluate.setEvaluate(content);
		evaluate.setEvaluateTime(evaluateTime);
		evaluateMapper.addEvaluate(evaluate);
	}

	@Override
	public List<Evaluate> getEvaluateByUserId(Integer userId) {
		List<Evaluate> list = evaluateMapper.getEvaluateByUserId(userId);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}

	@Override
	public List<Evaluate> getEvaluateByGoodsId(Integer goodsId) {
		// TODO Auto-generated method stub
		List<Evaluate> list = evaluateMapper.getEvaluateByGoodsId(goodsId);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}

}