package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Statistics;
import com.zpt.shop.main.mapper.StatisticsMapper;
import com.zpt.shop.main.service.StatisticsService;

@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	@Autowired
	private StatisticsMapper statisticsMapper;

	@Override
	public List<Statistics> getNumbyCity(String name, String starttime, String endtime) {
		// TODO Auto-generated method stub
		List<Statistics> list = statisticsMapper.getNumbyCity(name, starttime, endtime);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public List<Statistics> getNumbyTime(String name, String cityname) {
		// TODO Auto-generated method stub
		List<Statistics> list = statisticsMapper.getNumbyTime(name, cityname);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public List<Statistics> getNumbyName(String starttime,String endtime, String cityname) {
		// TODO Auto-generated method stub
		List<Statistics> list = statisticsMapper.getNumbyName(starttime, endtime, cityname);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public Page<Statistics> page(Query<Statistics> query) {
		// TODO Auto-generated method stub
		Page<Statistics> page = new Page<Statistics>();
		List<Statistics> list = statisticsMapper.listStatistics(query);
		Integer count = statisticsMapper.countStatistics(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;		
	}
}
