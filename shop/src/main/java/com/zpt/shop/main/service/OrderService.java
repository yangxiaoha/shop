package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;

public interface OrderService {
	
	public Page<Order> page(Query<Order> query);
	
	public boolean validate(Order order);
	
	public void updateState(Order order);
	
	public void seeOrder(Order order);

	/****************************************************************************/
	/**
	 * 添加订单
	 * @param Integer userId 用户id
	 * @param Order order 订单信息 
	 * @param String cartIds 购物车id
	 * */
	public void addOrder(Integer userId, Order order, String cartIds);
	
	/**
	 * 订单详情
	 * @param Integer userId 用户id
	 * @return 
	 * */
	public List<Order> getOrderDetail(Integer userId);

	/**
	 * 订单详情
	 * @param Integer orderId 订单id
	 * @return 
	 * */
	public List<Order> getOrderByOrderId(Integer orderId);

}
