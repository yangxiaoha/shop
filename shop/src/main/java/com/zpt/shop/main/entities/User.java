package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

public class User {

	private Integer id;
	
	private Integer pid;
	
	private Integer fpid;
	
	private String openid;
	
	private Date regtime;
	
	//可提现金额
	private BigDecimal money;
	
	private BigDecimal startmoney;
	
	private BigDecimal endmoney;
	
	//用户名
	private String name;

	private Date starttime;
	
	private Date endtime;
	
	private String isnot;
	
	public String getIsnot() {
		return isnot;
	}

	public void setIsnot(String isnot) {
		this.isnot = isnot;
	}

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

	public BigDecimal getStartmoney() {
		return startmoney;
	}

	public void setStartmoney(BigDecimal startmoney) {
		this.startmoney = startmoney;
	}

	public BigDecimal getEndmoney() {
		return endmoney;
	}

	public void setEndmoney(BigDecimal endmoney) {
		this.endmoney = endmoney;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getRegtime() {
		if(this.regtime != null){
			return new SimpleDateFormat("yyyy-MM-dd").format(this.regtime);
		}else{
			return "";
		}
	}

	public void setRegtime(Date regtime) {
		this.regtime = regtime;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getFpid() {
		return fpid;
	}

	public void setFpid(Integer fpid) {
		this.fpid = fpid;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
