package com.zpt.shop.main.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Order;

public interface OrderMapper {
	
	public List<Order> listOrder(Query<Order> query);
	
	public Integer countOrder(Query<Order> query);
	
	public List<Order> validate(Order order);
	
	public void updateState(Order order);
	
	public void seeOrder(Order order);
	
	public List<Order> seeOrderAll(@Param("orderId")Integer orderId);
	
	/*************************************************************************/

	public void addOrder(Order order);
	
	public Order getOrder(@Param("userId")Integer userId, @Param("orderNum")String orderNum);

	public List<Order> getOrderDetail(@Param("userId")Integer userId);

	public List<Order> getOrderByOrderId(@Param("orderId")Integer orderId);

	public List<Order> getOrderInfoByNoPay(@Param("ids")String ids);

	public List<Order> getOrderInfoByPay(@Param("ids")String ids);

	public void updateOrderState(@Param("ordercode")String ordercode, @Param("state")Integer state);

	public void updateOrderStateByOrderId(@Param("orderId")Integer orderId, @Param("state")Integer state);

	public Order getOrderInfoByCode(@Param("orderNum")String ordercode);

	public void updateOrder(Order order);

	public List<Order> getOrderByState(@Param("state")Integer state);

	public List<Order> getOrderByOrderIdAndSkuId(@Param("orderId")Integer orderId, @Param("skuId")Integer skuId);


}
