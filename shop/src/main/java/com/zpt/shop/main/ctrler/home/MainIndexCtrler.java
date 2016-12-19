package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.service.CartService;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.OrderDetailService;
import com.zpt.shop.main.service.OrderService;
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
@RequestMapping("home/mainindex")
public class MainIndexCtrler {
	
	private static Logger logger = LogManager.getLogger(MainIndexCtrler.class.getName());
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private SkuService skuService;
	
	@Autowired
	private ProValService proValService;
	
	@Autowired
	private GoodsTypeService goodsTypeService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private OrderDetailService orderDetailService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("home/index");
		String userId = "1";//先设置用户为1
		Integer pageStart = 0;
		Integer num = 3;
		//商品类型数据
		List<GoodsType> goodsTypeList = goodsTypeService.getGoodsType();
		//商品数据
		List<Goods> goodsList = goodsService.getGoods(pageStart, num);		
		//购物车数量
		Integer amount = cartService.selectAmount(userId);
		mv.addObject("goodsTypeMsg", goodsTypeList);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("amount", amount);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/loadIndex", method=RequestMethod.POST)
	public Map<String,Object> loadIndex(Integer pageStart, Integer num, String flag, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();
		//商品数据
		List<Goods> goodsList = goodsService.getGoods(pageStart, num);
		map.put("goodsMsg", goodsList);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectGoods", method=RequestMethod.POST)
	public Map<String,Object> selectGoods(String flag, Integer num, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();
		//根据商品类型查询商品数据
		Integer pageStart = 0;
		List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		map.put("state", true);
		map.put("goodsMsg", goodsList);
		return map;
	}
	
	//商品类型页
	@RequestMapping(value="/goodsType/{typeId}", method=RequestMethod.GET)
	public ModelAndView goodsType(@PathVariable("typeId") Integer typeId) {
		ModelAndView mv = new ModelAndView("home/type-detail");	
		Integer pageStart = 0;
		Integer num = 3;
		List<Goods> goodsList = goodsService.getGoodsByTypeId(pageStart, num, Integer.toString(typeId));
		//商品类型数据
		List<GoodsType> typeList = goodsTypeService.getType();
		mv.addObject("typeId", typeId);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("typeMsg", typeList);
		return mv;
	}
	
	//商品类型页
	@ResponseBody
	@RequestMapping(value="/goodsTypeLevel", method=RequestMethod.POST)
	public Map<String,Object> goodsTypeLevel(String flag, Integer num, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();	
		Integer pageStart = 0;
		List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		map.put("goodsMsg", goodsList);
		return map;
	}
	
	//商品详细页
	@RequestMapping(value="/goodsDetail/{goodsId}", method=RequestMethod.GET)
	public ModelAndView goodsDetail(@PathVariable("goodsId") Integer goodsId) {
		ModelAndView mv = new ModelAndView("home/goods-detail");
		String userId = "1";//先设置用户为1
		//商品数据
		Goods goodsList = goodsService.getGoodsById(goodsId);
		//商品属性
		List<ProVal> proList = proValService.getProByTypeId(goodsId);
		//购物车数量
		Integer amount = cartService.selectAmount(userId);
		mv.addObject("goodsId", goodsId);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("proMsg", proList);
		mv.addObject("amount", amount);
		return mv;
	}
	
	//商品详细页(库存信息)
	@ResponseBody
	@RequestMapping(value="/getGoodsStockInfo/{goodsId}", method=RequestMethod.POST)
	public Map<String,Object> getGoodsInfo(@PathVariable("goodsId") Integer goodsId) throws ParseException {
		Map<String,Object> map = new HashMap<String, Object>();
		//商品数据
		Goods goodsList = goodsService.getGoodsById(goodsId);
		//商品属性
		List<ProVal> proList = proValService.getProByTypeId(goodsId);
		//库存信息
		List<Sku> goodsSkuList = skuService.getGoodsStockInfo(goodsId);
		//订单信息(获取下单时间，下单小于半小时的商品保留，超过半小时的修改状态)
		String skuIds = "";
		for(int i=0; i<goodsSkuList.size(); i++) {
			if(skuIds != null && !("".equals(skuIds))) {
				skuIds = skuIds + "," + goodsSkuList.get(i).getId();
			}else {
				skuIds = goodsSkuList.get(i).getId().toString();
			}
		}
		List<OrderDetail> orderDetailList = orderDetailService.getorderDetailBySkuIds(skuIds);
		if(orderDetailList != null && orderDetailList.size() > 0) {
			for(int i=0; i<goodsSkuList.size(); i++) {
				for(int j=0; j<orderDetailList.size(); j++) {
					if(goodsSkuList.get(i).getId() == orderDetailList.get(j).getId()) {
						SimpleDateFormat matter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间格式
		                Date nowTime=new Date();//获取当前时间
		                String tmf= matter1.format(nowTime);

	                    Date now=matter1.parse(tmf);
	                    Date end=orderDetailList.get(j).getOrdertime();
	                    long cha=(now.getTime()-end.getTime())/ (1000 * 60 * 60 * 24);//计算时间差
	                    if(cha <= 30) {
	                    	Integer val = goodsSkuList.get(i).getNum()-orderDetailList.get(j).getNum();
	                    	goodsSkuList.get(i).setNum(val);
	                    }else {	                    	
	                    	Integer val = goodsSkuList.get(i).getNum()+orderDetailList.get(j).getNum();
	                    	goodsSkuList.get(i).setNum(val);
	                    	orderService.updateOrderStateByOrderId(orderDetailList.get(j).getOrderId());
	                    }
					}
				}
			}
		}
		map.put("state", true);
		map.put("goodsMsg", goodsList);
		map.put("proMsg", proList);
		map.put("goodsSkuMsg", goodsSkuList);
		return map;
	}

}