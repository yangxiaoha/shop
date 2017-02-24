package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;

import com.zpt.shop.main.entities.System;

public interface SystemMapper {
	
	public List<System> listSystem(Query<System> query);
	
	public Integer countSystem(Query<System> query);
	
	public List<System> validate(System system);
	
	public void updateSystem(System system);
	
	public void updateDefined(@Param("sysvalue")String sysvalue);
	
	public System suserDefined();
	
	public void updateIntro(@Param("sysvalue")String sysvalue);
	
	public System selIntro();

	public String getNotice();

	public String getSummary();
}
