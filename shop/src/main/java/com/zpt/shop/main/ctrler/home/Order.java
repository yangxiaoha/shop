package com.zpt.shop.main.ctrler.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.ProService;
import com.zpt.shop.main.service.ProValService;
import com.zpt.shop.main.service.SkuService;

/**
 * 功能说明:
 *
 * MainIndexCtrler.java
 *
 * Original Author: 林敏,2016年11月7日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/order")
public class Order {
	
	private static Logger logger = LogManager.getLogger(Order.class.getName());
	
	//添加购物车
	@ResponseBody
	@RequestMapping(value="/placeOrder/{skuId}", method=RequestMethod.POST)
	public Map<String,Object> placeOrder(@PathVariable("skuId") Integer skuId) {
		Map<String,Object> map = new HashMap<String, Object>();

		return map;
	}
	
	//立即购买
	@RequestMapping(value="/buyImmediately", method=RequestMethod.POST)
	public ModelAndView buyImmediately(String flag) {
		ModelAndView mv = new ModelAndView("home/index");
		return mv;
	}

}