package com.zpt.shop.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;

public interface GoodsService {
	
	public void insertGoods(Goods goods,HttpServletRequest request, HttpSession session);
	
	public void deleteGoods(String ids);
	
	public void updateGoods(Goods goods,HttpServletRequest request, HttpSession session);
	
	public void stickGoods(Goods goods);
	
	public void downGoods(Goods goods);
	
	public Page<Goods> page(Query<Goods> query);
	
	public boolean validate(Goods goods);
	
	public Goods getGoodsId(Integer goodsId);
	
	public List<Goods> getGoodsByBrandId(String brandId);
	
	public void updateContent(Integer id, String content);
	
	public void updateState(Integer id, Integer state);
	
	/**
	 * 分页查找商品
	 * @param String pageStart 开始的下标
	 * */
	public List<Goods> getGoods(Integer pageStart, Integer num, String flag, String keyword, String typeId);

	/**
	 * 通过查询条件查找商品
	 * @param String pageStart 开始的下标
	 * @param String flag （最新、人气、现货）
	 * @param String keyword （关键字）
	 * @param String typeId （类型id）
	 * */
	public List<Goods> getGoodsByCondition(Integer pageStart, Integer num, String flag, String keyword, String typeId);
	
	/**
	 * 通过商品id查找商品
	 * @param Integer goodsId
	 * */
	public Goods getGoodsById(Integer goodsId);

	/**
	 * 通过商品类型id查找商品
	 * @param String pageStart 开始的下标
	 * @param String typeId（类型id）
	 * */
	public List<Goods> getGoodsByTypeId(Integer pageStart, Integer num, String typeId);

	/**
	 * 修改商品购买人数
	 * @param long num 购买人数
	 * */
	public void updateNum(Integer id, long num);
	
	/**
	 * 修改商品总数
	 * @param int total 商品总数
	 * */
	public void updateTotal(Integer goodsId, int total);

	/**
	 * 符合查询条件的商品总数
	 * @param String flag （最新、人气、现货）
	 * @param String keyword （关键字）
	 * @param String typeId （类型id）
	 * */
	public Integer getGoodsTotal(String flag, String keyword, String typeId);
	
	//上传图片到服务器
	public String uploadPhoto(CommonsMultipartFile cmFile, String relaPath,Integer i);

}
