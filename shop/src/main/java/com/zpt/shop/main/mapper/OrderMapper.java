package com.zpt.shop.main.mapper;

import java.util.List;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;

public interface OrderMapper {
	
	public List<Order> listOrder(Query<Order> query);
	
	public Integer countOrder(Query<Order> query);
	
	public List<Order> validate(Order order);
	
}
