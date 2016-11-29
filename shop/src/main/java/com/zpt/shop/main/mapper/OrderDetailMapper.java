package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.OrderDetail;

public interface OrderDetailMapper {
	
	public List<OrderDetail> getAllOrderDetail(@Param("orderId")Integer orderId);
	
}
