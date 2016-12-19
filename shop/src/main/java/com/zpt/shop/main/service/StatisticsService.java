package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Statistics;

public interface StatisticsService {
	
	public Page<Statistics> page(Query<Statistics> query);
	
	public List<Statistics> getNumbyCity(String name,String starttime,String endtime);
	
	public List<Statistics> getNumbyTime(String name,String cityname);
	
	public List<Statistics> getNumbyName(String starttime,String endtime,String cityname);

}
