package com.zpt.shop.main.ctrler.home;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.main.entities.Banner;
import com.zpt.shop.main.entities.Evaluate;
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.BannerService;
import com.zpt.shop.main.service.CartService;
import com.zpt.shop.main.service.EvaluateService;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.ProValService;
import com.zpt.shop.main.service.SkuService;
import com.zpt.shop.main.service.SystemService;

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
	private SystemService systemService;

	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private EvaluateService evaluateService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request) {
		//只展示前20条数据
		ModelAndView mv = new ModelAndView("home/index");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();
		Integer pageStart = 0;
		Integer num = 20;
		String flag = "0";
		String keyword = "";
		String typeId = "";
		//商品类型数据
		List<GoodsType> goodsTypeList = goodsTypeService.getGoodsType();
		//商品数据
		List<Goods> goodsList = goodsService.getGoods(pageStart, num, flag, keyword, typeId);		
		//banner
		List<Banner> bannerList = bannerService.getAllBanner();
		//购物车数量
		Integer amount = cartService.selectAmount(userId);
		//公告
		String notice = systemService.getNotice();	
		//符合商品数量的个数
		Integer total = goodsService.getGoodsTotal(flag, keyword, typeId);
		mv.addObject("goodsTypeMsg", goodsTypeList);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("banner", bannerList);
		mv.addObject("amount", amount);
		mv.addObject("notice", notice);
		mv.addObject("total", total);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/loadIndex", method=RequestMethod.POST)
	public Map<String,Object> loadIndex(HttpServletRequest request, Integer pageStart, Integer num, String flag, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();
		
		//商品数据
		if(("0").equals(flag) && keyword == null && typeId == null) {
			List<Goods> goodsList = goodsService.getGoods(pageStart, num, flag, keyword, typeId);
			map.put("goodsMsg", goodsList);
		}else {
			List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
			map.put("goodsMsg", goodsList);
		}			
		return map;
	}
	
	@RequestMapping(value="/selectGoods", method=RequestMethod.POST)
	public ModelAndView selectGoods(HttpServletRequest request, String flag, String keyword, String typeId) throws UnsupportedEncodingException {
		ModelAndView mv = new ModelAndView("home/index");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();

		//根据商品类型查询商品数据		
		Integer pageStart = 0;
		Integer num = 20;
		List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		//商品类型数据
		List<GoodsType> goodsTypeList = goodsTypeService.getGoodsType();
		//banner
		List<Banner> bannerList = bannerService.getAllBanner();
		//符合商品数量的个数
		Integer total = goodsService.getGoodsTotal(flag, keyword, typeId);
		//购物车数量
		Integer amount = cartService.selectAmount(userId);
		//公告
		String notice = systemService.getNotice();	
		mv.addObject("state", true);
		mv.addObject("flag", flag);
		mv.addObject("banner", bannerList);
		mv.addObject("total", total);
		mv.addObject("amount", amount);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("goodsTypeMsg", goodsTypeList);
		mv.addObject("notice", notice);
		return mv;
	}
	
	/*@ResponseBody
	@RequestMapping(value="/selectGoods", method=RequestMethod.POST)
	public Map<String,Object> selectGoods(String flag, Integer num, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();
		//根据商品类型查询商品数据
		Integer pageStart = 0;
		List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		//符合商品数量的个数
		Integer total = goodsService.getGoodsTotal(flag, keyword, typeId);
		map.put("state", true);
		map.put("total", total);
		map.put("goodsMsg", goodsList);
		return map;
	}*/
	
	//商品类型页
	@RequestMapping(value="/goodsType/{typeId}", method=RequestMethod.GET)
	public ModelAndView goodsType(@PathVariable("typeId") Integer typeId) {
		ModelAndView mv = new ModelAndView("home/type-detail");	
		Integer pageStart = 0;
		Integer num = 10;
		String flag = "";
		String keyword = "";
		List<Goods> goodsList = goodsService.getGoodsByTypeId(pageStart, num, Integer.toString(typeId));
		//商品类型数据
		List<GoodsType> typeList = goodsTypeService.getType();
		//符合商品数量的个数
		Integer total = goodsService.getGoodsTotal(flag, keyword, typeId.toString());
		mv.addObject("typeId", typeId);
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("typeMsg", typeList);
		mv.addObject("total", total);
		return mv;
	}
	
	//商品类型页
	@ResponseBody
	@RequestMapping(value="/goodsTypeLevel", method=RequestMethod.POST)
	public Map<String,Object> goodsTypeLevel(String flag, Integer num, String keyword, String typeId) {
		Map<String,Object> map = new HashMap<String, Object>();	
		Integer pageStart = 0;
		List<Goods> goodsList = goodsService.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		//符合商品数量的个数
		Integer total = goodsService.getGoodsTotal(flag, keyword, typeId.toString());
		map.put("goodsMsg", goodsList);
		map.put("total", total);
		return map;
	}
	
	//商品详细页
	@RequestMapping(value="/goodsDetail/{goodsId}", method=RequestMethod.GET)
	public ModelAndView goodsDetail(HttpServletRequest request, @PathVariable("goodsId") Integer goodsId) {
		ModelAndView mv = new ModelAndView("home/goods-detail");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();//先设置用户为1
		//评论		
		List<Evaluate> evaluateList = evaluateService.getEvaluateByGoodsId(goodsId);
		//商品数据
		Goods goodsList = goodsService.getGoodsById(goodsId);
		//商品图片
		List<Sku> goodsImgList = skuService.getGoodsImgByGoodsId(goodsId);
		//商品属性
		List<ProVal> proList = proValService.getProByTypeId(goodsId);
		//购物车数量
		Integer amount = cartService.selectAmount(userId);
		mv.addObject("evaluateMsg", evaluateList);		
		mv.addObject("goodsMsg", goodsList);
		mv.addObject("goodsImgMsg", goodsImgList);
		mv.addObject("proMsg", proList);
		mv.addObject("goodsId", goodsId);
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
		//超过半小时还未支付的订单视为订单关闭
		orderService.closeOrder();
		//查询指定库存信息
		List<Sku> goodsSkuList = skuService.getGoodsStockInfo(goodsId);
		map.put("state", true);
		map.put("goodsMsg", goodsList);
		map.put("proMsg", proList);
		map.put("goodsSkuMsg", goodsSkuList);
		return map;
	}
	
	@RequestMapping(value="/summary", method=RequestMethod.GET)
	public ModelAndView summary(){
		ModelAndView mv = new ModelAndView("home/summary");
		String summary = systemService.getSummary();
		mv.addObject("summary", summary);
		return mv;
	}

}