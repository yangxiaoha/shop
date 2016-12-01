package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.mapper.OrderDetailMapper;
import com.zpt.shop.main.service.OrderDetailService;

/**
 * 功能说明:
 *
 * OrderDetailImpl.java
 *
 * Original Author: 林敏,2016年11月30日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Service
public class OrderDetailImpl implements OrderDetailService {

	@Autowired
	private OrderDetailMapper orderDetailMapper;

	@Override
	public List<OrderDetail> getAllOrderDetail(Integer orderId) {
		// TODO Auto-generated method stub
		if(orderId == null){
			orderId = 0;
		}
		return orderDetailMapper.getAllOrderDetail(orderId);
	}

}