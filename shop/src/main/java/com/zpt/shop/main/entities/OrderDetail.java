package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderDetail {
	
	private Integer id;
	
	private Integer orderId;
	
	private Integer skuId;
	
	private Integer num;
	
	private BigDecimal price;
	
	private String proname;
	
	private String provalue;
	
	//商品总价
	private BigDecimal totalPrice;	

	//商品名称
	private String name;
	
	//商品id
	private Integer goodsId;
	
	//商品图片
	private String url;
	
	//商品属性
	private String val;
	
	//下单时间
	private Date ordertime;	
	
	private List<User> user;
	
	public List<User> getUser() {
		return user;
	}

	public void setUser(List<User> user) {
		this.user = user;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getProvalue() {
		return provalue;
	}

	public void setProvalue(String provalue) {
		this.provalue = provalue;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getSkuId() {
		return skuId;
	}

	public void setSkuId(Integer skuId) {
		this.skuId = skuId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public Date getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(Date ordertime) {
		this.ordertime = ordertime;
	}

}
