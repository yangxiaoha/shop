package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.OrderDetail;

public interface OrderDetailMapper  {
	
	public List<OrderDetail> getAllOrderDetail(@Param("orderId")Integer orderId);

	/**
	 * 添加订单详情
	 * */
	public void addOrderDetail(@Param("orderId")Integer id, @Param("list")List<Cart> cartsList);

	/**
	 * 查询订单详情
	 * @param String skuIds
	 * */
	public List<OrderDetail> getorderDetailBySkuIds(@Param("ids")String skuIds);

	/**
	 * 添加订单详情
	 * @param String skuIds
	 * */
	public List<OrderDetail> getOrderDetail(@Param("ordercode")String ordercode);
	
}




