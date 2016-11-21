package com.zpt.shop.main.ctrler.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;

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
@RequestMapping("home/mainindex")
public class MainIndexCtrler {
	
	private static Logger logger = LogManager.getLogger(MainIndexCtrler.class.getName());
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private GoodsTypeService goodsTypeService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("home/index");
		//商品类型数据
		List<GoodsType> goodsTypeList = goodsTypeService.getGoodsType();
		//商品数据
		List<Goods> goodsList = goodsService.getGoods();
		mv.addObject("goodsTypeMsg", goodsTypeList);
		mv.addObject("goodsMsg", goodsList);
		return mv;
	}
	
	@RequestMapping(value="/goodsAttr", method=RequestMethod.POST)
	public ModelAndView goodsAttr(String flag) {
		ModelAndView mv = new ModelAndView("home/index");
		//商品类型数据
		List<GoodsType> goodsTypeList = goodsTypeService.getGoodsType();
		//商品数据
		List<Goods> goodsList = goodsService.getGoods();
		mv.addObject("goodsTypeMsg", goodsTypeList);
		mv.addObject("goodsMsg", goodsList);
		return mv;
	}
	
	@RequestMapping(value="/goodsType", method=RequestMethod.GET)
	public Map<String,Object> goodsType(String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();
		//根据商品类型查找商品数据
		List<Goods> goodsList = goodsService.getGoodsByType(typeId);
		map.put("state", true);
		map.put("goodsMsg", goodsList);
		return map;
	}
}