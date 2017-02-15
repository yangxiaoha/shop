package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

public class Order {
	
	private Integer id;
	
	private Integer userId;
	
	//收货地址
	private String address;
	
	//下单时间
	private Date ordertime;
	
	//物流编号
	private String logisticsnum;
	
	//物流商家
	private String logistics;
	
	//订单状态
	private Integer state;
	
	//收货人姓名
	private String name;
	
	//收货人电话
	private String phone;
	
	//商品总价
	private BigDecimal totalPrice;
	
	//商品总量
	private Integer nums;
	
	//商品名称合并
	private String goodsnames;

	//订单详情
	private List<OrderDetail> orderDetail;
	
	//备注
	private String memo;
	
	//订单编号
	private String ordernum;	
	
	private String postalCode;
	
	private String provinceName;
	
	private String cityName;	
	
	private String countryName;
	
	public String getGoodsnames() {
		return goodsnames;
	}

	public void setGoodsnames(String goodsnames) {
		this.goodsnames = goodsnames;
	}

	public Integer getNums() {
		return nums;
	}

	public void setNums(Integer nums) {
		this.nums = nums;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

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
			return new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(this.ordertime);
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
