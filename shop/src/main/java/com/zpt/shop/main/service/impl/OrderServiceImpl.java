package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.mapper.OrderMapper;
import com.zpt.shop.main.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Override
	public Page<Order> page(Query<Order> query) {
		// TODO Auto-generated method stub
		Page<Order> page = new Page<Order>();
		List<Order> list = orderMapper.listOrder(query);
		Integer count = orderMapper.countOrder(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Order order) {
		// TODO Auto-generated method stub
		List<Order> list = orderMapper.validate(order);
		if(list != null && list.size()>0){
			return false;
		}
		return true;
	}

}
