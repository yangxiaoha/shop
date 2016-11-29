package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.OrderDetail;

public interface OrderDetailService {
	
	public List<OrderDetail> getAllOrderDetail(Integer orderId);

}
