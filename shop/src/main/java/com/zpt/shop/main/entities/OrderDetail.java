package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.util.List;

public class OrderDetail {
	
	public Integer id;
	
	public Integer orderId;
	
	public Integer skuId;
	
	public Integer num;
	
	public BigDecimal price;
	
	public BigDecimal totalPrice;
	
	public Integer goodsId;//商品id
	
	public String name;//商品名称
	
	public String url;//商品图片
	
	public String val;//商品属性
	
	//商品详情
	private List<Sku> sku;

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

	public List<Sku> getSku() {
		return sku;
	}

	public void setSku(List<Sku> sku) {
		this.sku = sku;
	}	

}
