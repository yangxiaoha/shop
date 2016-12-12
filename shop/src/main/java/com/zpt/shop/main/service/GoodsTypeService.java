package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.GoodsType;

public interface GoodsTypeService {

	public List<GoodsType> selectTypeTree(Integer pid);

	public List<GoodsType> getGoodsType();
	
	public Page<GoodsType> page(Query<GoodsType> query);
	
	public boolean validate(GoodsType goodstype);
	
	public void insertGoodsType(GoodsType goodstype);
	
	public void deleteGoodsType(String ids);
	
	public void updateGoodsType(GoodsType goodstype);

	/**
	 * 获取商品类型
	 * */
	public List<GoodsType> getType();
	
}
