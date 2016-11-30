package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;

public interface OrderService {
	
	public Page<Order> page(Query<Order> query);
	
	public boolean validate(Order order);
	
	public void updateState(Order order);
	
	public void seeOrder(Order order);
	
}
