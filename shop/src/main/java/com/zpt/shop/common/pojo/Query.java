
package com.zpt.shop.common.pojo;

import com.alibaba.fastjson.JSON;

/**
 * 功能说明:
 *
 * Query.java
 *
 * Original Author: 刘腾达,2016年5月20日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class Query<T>{

	private Integer draw;
	//页数
	private Integer start;
	//每页长度
	private Integer length;
	//排序字段
	private String orderName;
	//排序方式
	private String orderDir;
	//搜索条件
	private String search;
	
	private String searchObj;
	//对象搜索
	private T obj;
	
	private String className;

	public Integer getDraw() {
		return draw;
	}

	public void setDraw(Integer draw) {
		this.draw = draw;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getLength() {
		return length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getOrderDir() {
		return orderDir;
	}

	public void setOrderDir(String orderDir) {
		this.orderDir = orderDir;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public T getObj() {
		return obj;
	}

	public void setObj(T obj) {
		this.obj = obj;
	}

	public void setObj() {
		if(this.getSearchObj() != null && this.getClassName() != null){
			try {
				this.obj = JSON.parseObject(this.getSearchObj(),Class.forName(getClassName()));
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public String getSearchObj() {
		return searchObj;
	}

	public void setSearchObj(String searchObj) {
		this.searchObj = searchObj;
		this.setObj();
	}

	public String getClassName() {
		return "com.zpt.shop.main.entities." + className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}
