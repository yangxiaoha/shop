package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.Sku;

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
	 * @return List<Order>
	 * */
	public List<Order> getOrderDetail(Integer userId);

	/**
	 * 订单详情
	 * @param Integer orderId 订单id
	 * @return List<Order>
	 * */
	public List<Order> getOrderByOrderId(Integer orderId);
	
	/**
	 * 订单详情
	 * @param String orderNum 订单号
	 * @return List<Sku>
	 * */
	public List<Sku> getOrderByOrderNum(String orderNum);

	/**
	 * 分销下单未付款查询
	 * @param String ids 代理人
	 * @return List<Order>
	 * */
	public List<Order> getOrderInfoByNoPay(String ids);

	/**
	 * 分销下单已付款查询
	 * @param String ids 代理人
	 * @return List<Order>
	 * */
	public List<Order> getOrderInfoByPay(String ids);

	/**
	 * 修改订单状态
	 * @param String ordercode 订单号
	 * */
	public void updateOrderState(String ordercode);

	/**
	 * 修改订单状态
	 * @param Integer orderId 订单id
	 * */
	public void updateOrderStateByOrderId(Integer orderId);

}
