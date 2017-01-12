package com.zpt.shop.main.entities;

import java.util.List;

public class GoodsType {

	private Integer id;
	
	private Integer pid;
	
	private String name;
	
	private String meno;
	
	private Boolean isParent;
	
	private Integer state;
	
	//商品类型详情
	private List<GoodsType> goodsType;
	
	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMeno() {
		return meno;
	}

	public void setMeno(String meno) {
		this.meno = meno;
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public List<GoodsType> getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(List<GoodsType> goodsType) {
		this.goodsType = goodsType;
	}

}
