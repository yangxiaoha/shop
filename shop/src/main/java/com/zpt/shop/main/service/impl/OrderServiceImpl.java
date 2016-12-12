package com.zpt.shop.main.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.common.pojo.RandomArray;
import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.mapper.CartMapper;
import com.zpt.shop.main.mapper.OrderDetailMapper;
import com.zpt.shop.main.mapper.OrderMapper;
import com.zpt.shop.main.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private OrderDetailMapper orderDetailMapper;

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
	
	@Override
	public void updateState(Order order) {
		// TODO Auto-generated method stub
		orderMapper.updateState(order);		
	}

	@Override
	public void seeOrder(Order order) {
		// TODO Auto-generated method stub
		orderMapper.seeOrder(order);		
	}

	/**
	 * 添加订单
	 * */
	@Override
	public void addOrder(Integer userId, Order order, String cartIds) {
		// TODO Auto-generated method stub
		// 下单时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		Date ordertime = new Date();
		try {
			ordertime = df.parse(df.format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		order.setUserId(userId);
		order.setOrdertime(ordertime);
		order.setOrdernum(order.getOrdernum());
		order.setState(1);
		// 添加订单
		orderMapper.addOrder(order);
		// 获取添加的订单id
		Order orderInfo = orderMapper.getOrder(userId, order.getOrdernum());
		// 添加订单详情
		List<Cart> cartsList = cartMapper.getCartByCartIdsAndUserId(userId, cartIds);	
		orderDetailMapper.addOrderDetail(orderInfo.getId(), cartsList);
		// 删除购物车
		cartMapper.deleteCartInfo(cartIds);
	}

	/**
	 * 订单详情
	 * */
	@Override
	public List<Order> getOrderDetail(Integer userId) {
		// TODO Auto-generated method stub
		List<Order> list = orderMapper.getOrderDetail(userId);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}

	/**
	 * 订单详情
	 * */
	@Override
	public List<Order> getOrderByOrderId(Integer orderId) {
		// TODO Auto-generated method stub
		List<Order> list = orderMapper.getOrderByOrderId(orderId);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}
	
	/**
	 * 订单详情
	 * */
	@Override
	public List<Sku> getOrderByOrderNum(String orderNum) {
		// TODO Auto-generated method stub
		List<Sku> list = orderMapper.getOrderByOrderNum(orderNum);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}


	/**
	 * 分销下单未付款查询
	 * */
	@Override
	public List<Order> getOrderInfoByNoPay(String ids) {
		// TODO Auto-generated method stub
		List<Order> list = orderMapper.getOrderInfoByNoPay(ids);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}
	
	/**
	 * 分销下单已付款查询
	 * */
	@Override
	public List<Order> getOrderInfoByPay(String ids) {
		// TODO Auto-generated method stub
		List<Order> list = orderMapper.getOrderInfoByPay(ids);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}

	/**
	 * 修改订单状态
	 * */
	@Override
	public void updateOrderState(String ordercode) {
		// TODO Auto-generated method stub
		Integer state = 2;
		orderMapper.updateOrderState(ordercode, state);
	}

}
