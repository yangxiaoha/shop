package com.zpt.shop.main.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.mapper.CartMapper;
import com.zpt.shop.main.mapper.OrderDetailMapper;
import com.zpt.shop.main.mapper.OrderMapper;
import com.zpt.shop.main.mapper.SkuMapper;
import com.zpt.shop.main.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private SkuMapper skuMapper;
	
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
	/**
	 * 
	 */
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
		order.setState(1);
		// 添加订单
		orderMapper.addOrder(order);
		// 获取添加的订单id
		Order orderInfo = orderMapper.getOrder(userId, order.getOrdernum());
		// 添加订单详情
		List<Cart> cartsList = cartMapper.getCartByCartIdsAndUserId(userId, cartIds);			
		orderDetailMapper.addOrderDetail(orderInfo.getId(), cartsList);
		
		//减少库存
		List<OrderDetail> orderDetailsList = orderDetailMapper.getOrderDetail(order.getOrdernum());//订单里商品信息
		String skuIds = "";
		for(int i=0; i<orderDetailsList.size(); i++) {
			if(skuIds != null && !("".equals(skuIds))) {
				skuIds = skuIds + "," + orderDetailsList.get(i).getSkuId();
			}else {
				skuIds = orderDetailsList.get(i).getSkuId().toString();
			}
		}
		List<Sku> goodsSkuList = skuMapper.getSkuInfoByIds(skuIds);//商品具体信息
		for(int i=0; i<orderDetailsList.size(); i++) {
			for(int j=0; j<goodsSkuList.size(); j++) {
				if(orderDetailsList.get(i).getSkuId() == goodsSkuList.get(j).getId()) {
					Integer num = goodsSkuList.get(j).getNum() - orderDetailsList.get(i).getNum();
					//修改库存数量
					skuMapper.updateSkuNum(goodsSkuList.get(j).getId(), num);
				}
			}
		}
		
		// 删除购物车
		cartMapper.deleteCartInfo(cartIds);
	}
	
	/**
	 * 修改订单信息
	 * */
	@Override
	public void updateOrder(Order order) {
		// TODO Auto-generated method stub
		orderMapper.updateOrder(order);
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
	public Order getOrderInfoByCode(String ordercode) {
		// TODO Auto-generated method stub
		Order list = orderMapper.getOrderInfoByCode(ordercode);
		if(list != null && !("".equals(list))){
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
	public void updateOrderState(String ordercode, Integer state) {
		// TODO Auto-generated method stub
		orderMapper.updateOrderState(ordercode, state);
	}
	
	/**
	 * 修改订单状态
	 * */
	@Override
	public void updateOrderStateById(Integer orderId, Integer state) {
		// TODO Auto-generated method stub
		orderMapper.updateOrderStateByOrderId(orderId, state);
	}

	/**
	 * 修改订单状态
	 * */
	@Override
	public List<Order> updateOrderStateByOrderId(Integer orderId, Integer state) {
		// TODO Auto-generated method stub
		orderMapper.updateOrderStateByOrderId(orderId, state);
		List<Order> order = orderMapper.getOrderByOrderId(orderId);
		List<Order> list = orderMapper.getOrderDetail(order.get(0).getUserId());
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}

	/**
	 * 查询未支付订单
	 * @throws ParseException 
	 * */
	@Override
	public void closeOrder() throws ParseException {
		// TODO Auto-generated method stub
		List<Order> orderList = orderMapper.getOrderByState(1);
		//查询所有库存信息
		List<Sku> allSkuList = skuMapper.getAllGoodsStockInfo();
		if(orderList != null && orderList.size() > 0) {
			for(int i=0; i<orderList.size(); i++) {
                SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");  
                Date nowTime=new Date();
                String fromDate = orderList.get(i).getOrdertime();//下单时间  
                String toDate = simpleFormat.format(nowTime);//获取当前时间                 
                long from = simpleFormat.parse(fromDate).getTime();
                long to = simpleFormat.parse(toDate).getTime();   
                int minutes = (int) ((to - from)/(1000 * 60));
				if(minutes > 30) {
					List<OrderDetail> detailList = orderDetailMapper.getAllOrderDetail(orderList.get(i).getId());
					for(int j=0; j<detailList.size(); j++) {
						for(int s=0; s<allSkuList.size(); s++) {
							if(detailList.get(j).getSkuId() == allSkuList.get(s).getId()) {
								Integer num = allSkuList.get(s).getNum() + detailList.get(j).getNum();
								//更新库存数
								skuMapper.updateSkuNum(allSkuList.get(s).getId(), num);
							}
						}
					}
					orderMapper.updateOrderStateByOrderId(orderList.get(i).getId(), 0);					
				}
			}
		}
	}

}
