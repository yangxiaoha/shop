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
	
	/*************************************************************************/

	public void addOrder(Order order);
	
	public Order getOrder(@Param("userId")Integer userId, @Param("orderNum")String orderNum);

	public List<Order> getOrderDetail(@Param("userId")Integer userId);

	public List<Order> getOrderByOrderId(@Param("orderId")Integer orderId);

}
