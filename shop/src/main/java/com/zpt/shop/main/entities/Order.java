package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

public class Order {
	
	public Integer id;
	
	public Integer userId;
	
	//收货地址
	public String address;
	
	//下单时间
	public Date ordertime;
	
	//物流编号
	public String logisticsnum;
	
	//物流商家
	public String logistics;
	
	//订单状态
	public Integer state;
	
	//收货人姓名
	public String name;
	
	//收货人电话
	public String phone;
	
	//商品总价
	public BigDecimal totalPrice;
	
	//备注
	public String memo;
	
	//订单编号
	public String ordernum;
	
	//订单详情
	private List<OrderDetail> orderDetail;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getOrdertime() {
		if(this.ordertime != null){
			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(this.ordertime);
		}else{
			return "";
		}
	}

	public void setOrdertime(Date ordertime) {
		this.ordertime = ordertime;
	}

	public String getLogisticsnum() {
		return logisticsnum;
	}

	public void setLogisticsnum(String logisticsnum) {
		this.logisticsnum = logisticsnum;
	}

	public String getLogistics() {
		return logistics;
	}

	public void setLogistics(String logistics) {
		this.logistics = logistics;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public List<OrderDetail> getOrderDetail() {
		return orderDetail;
	}

	public void setOrderDetail(List<OrderDetail> orderDetail) {
		this.orderDetail = orderDetail;
	}	
	
}
