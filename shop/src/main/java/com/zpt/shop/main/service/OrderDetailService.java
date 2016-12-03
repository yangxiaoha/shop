package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.OrderDetail;

/**
 * 功能说明:
 *
 * OrderDetailService.java
 *
 * Original Author: 林敏,2016年11月30日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface OrderDetailService {
	
	public List<OrderDetail> getAllOrderDetail(Integer orderId);

}
