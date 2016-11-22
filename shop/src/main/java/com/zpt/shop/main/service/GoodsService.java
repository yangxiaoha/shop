package com.zpt.shop.main.service;

import java.util.List;


import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;

public interface GoodsService {
	
	public void insertGoods(Goods goods);
	
	public void deleteGoods(String ids);
	
	public void updateGoods(Goods goods);
	
	public void stickGoods(Goods goods);
	
	public Page<Goods> page(Query<Goods> query);
	
	public boolean validate(Goods goods);
	
	public List<Goods> getGoodsByBrandId(String brandId);
	
	public Goods getGoodsId(Integer goodsId);

	public List<Goods> getGoods();

	/**
	 * 通过商品类型查找商品
	 * @param String typeId
	 * */
	public List<Goods> getGoodsByCondition(String flag, String keyword, String typeId);
	
}
