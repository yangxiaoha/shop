package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;

public interface GoodsMapper {
	
	public void insertGoods(Goods goods);
	
	public void deleteGoods(@Param("ids")String ids);
	
	public void updateGoods(Goods goods);
	
	public void stickGoods(Goods goods);
	
	public List<Goods> listGoods(Query<Goods> query);
	
	public Integer countGoods(Query<Goods> query);
	
	public List<Goods> validate(Goods goods);
	
	public List<Goods> getGoodsByBrand(@Param("brandId")String brandId);
	
	public Goods getGoodsId(@Param("goodsId")Integer goodsId);

}
