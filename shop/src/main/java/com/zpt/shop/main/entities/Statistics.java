package com.zpt.shop.main.entities;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Statistics {
	
	private Integer id;
	
	private String cityname;
	
	private Date ordertime;
	
	private String name;
	
	private String num;
	
	public Date starttime;
	
	public Date endtime;	
	
	public String getStarttime() {
		if(this.starttime != null){
			return new SimpleDateFormat("yyyy-MM-dd").format(this.starttime);
		}else{
			return "";
		}
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		if(this.endtime != null){
			return new SimpleDateFormat("yyyy-MM-dd").format(this.endtime);
		}else{
			return "";
		}
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCityname() {
		return cityname;
	}

	public void setCityname(String cityname) {
		this.cityname = cityname;
	}

	public String getOrdertime() {
		if(this.ordertime != null){
			return new SimpleDateFormat("yyyy-MM-dd").format(this.ordertime);
		}else{
			return "";
		}
	}

	public void setOrdertime(Date ordertime) {
		this.ordertime = ordertime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}	

}
