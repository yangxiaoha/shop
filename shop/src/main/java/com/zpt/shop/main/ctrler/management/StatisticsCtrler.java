package com.zpt.shop.main.ctrler.management;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Statistics;
import com.zpt.shop.main.service.StatisticsService;

@Controller
@RequestMapping("/management/statistics")
public class StatisticsCtrler {
	
	@Autowired
	private StatisticsService statisticsService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/statistics/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Statistics> listData(Query<Statistics> query){
		Page<Statistics> page = statisticsService.page(query);
		return page;		
	}
	
	@ResponseBody
	@RequestMapping(value = "/getNumbyCity",method = RequestMethod.POST)
	public List<Statistics> getNumbyCity(String name, String starttime, String endtime){
		List<Statistics> list = null;
		try {
			list = statisticsService.getNumbyCity(name, starttime, endtime);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getNumbyName",method = RequestMethod.POST)
	public List<Statistics> getNumbyName(String starttime,String endtime, String cityname){
		List<Statistics> list = null;
		try {
			list = statisticsService.getNumbyName(starttime, endtime, cityname);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

}
