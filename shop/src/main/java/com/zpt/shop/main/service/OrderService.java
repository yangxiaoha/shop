package com.zpt.shop.main.service;

import java.text.ParseException;
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
	 * 修改订单信息
	 * @param Order order 订单信息 
	 * */
	public void updateOrder(Order order);
	
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
	 * @param String ordercode 订单号
	 * @return Order
	 * */
	public Order getOrderInfoByCode(String ordercode);

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
	 * @param Integer state 订单状态
	 * */
	public void updateOrderState(String ordercode, Integer state);
	
	/**
	 * 修改订单状态
	 * @param Integer orderId 订单id
	 * @param Integer state 订单状态
	 * */
	public void updateOrderStateById(Integer orderId, Integer state);

	/**
	 * 修改订单状态
	 * @param Integer orderId 订单id
	 * @param Integer state 订单状态
	 * */
	public List<Order> updateOrderStateByOrderId(Integer orderId, Integer state);

	/**
	 * 查询未支付订单
	 * @param Integer orderId 订单id
	 * */
	public void closeOrder() throws ParseException ;

	/**
	 * 订单详情
	 * @param Integer orderId 订单id
	 * @param Integer skuId 库存id
	 * @return List<Order>
	 * */
	public List<Order> getOrderByOrderIdAndSkuId(Integer orderId, Integer skuId);

}
