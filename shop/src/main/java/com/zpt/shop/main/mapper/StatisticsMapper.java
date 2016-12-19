package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Statistics;

public interface StatisticsMapper {
	
	public List<Statistics> listStatistics(Query<Statistics> query);
	
	public Integer countStatistics(Query<Statistics> query);
	
	public List<Statistics> getNumbyCity(@Param("name")String name,@Param("starttime")String starttime,@Param("endtime")String endtime);
	
	public List<Statistics> getNumbyTime(String name,String cityname);
	
	public List<Statistics> getNumbyName(@Param("starttime")String starttime,@Param("endtime")String endtime,@Param("cityname")String cityname);

}
