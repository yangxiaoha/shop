package com.zpt.shop.common.pojo;

import java.util.List;

public class Page<T> {
	//页数
	private Integer iTotalRecords;
	private Integer iTotalDisplayRecords;
	//原样返回前端传过来的数据
	private Integer draw;
	//返回的数据
	private List<T> aaData;
//	private int page;
//	private int thispage;
//	private String last;
	public Page() {
	}

	public Integer getiTotalRecords() {
		return iTotalRecords;
	}

	public void setiTotalRecords(Integer iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	public Integer getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setiTotalDisplayRecords(Integer iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}
	
	public List<T> getAaData() {
		return aaData;
	}

	public void setAaData(List<T> aaData) {
		this.aaData = aaData;
	}
	
	public Integer getDraw() {
		return draw;
	}

	public void setDraw(Integer draw) {
		this.draw = draw;
	}

}
