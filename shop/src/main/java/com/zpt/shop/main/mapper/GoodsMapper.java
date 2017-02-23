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
	
	public void updateQuantity(@Param("id")Integer id,@Param("quantity")Integer quantity);
	
	public List<Goods> getGoodsByBrand(@Param("brandId")String brandId);
	
	public Goods getGoodsId(@Param("goodsId")Integer goodsId);

	public List<Goods> getGoods(@Param("pageStart")Integer pageStart, @Param("num")Integer num);

	public List<Goods> getGoodsByCondition(@Param("pageStart")Integer pageStart, @Param("num")Integer num, @Param("flag")String flag, @Param("keyword")String keyword, @Param("typeId")String typeId);

	public Goods getLowGoodsById(@Param("goodsId")Integer goodsId);	
	
	public Goods getHighGoodsById(@Param("goodsId")Integer goodsId);

	public Goods getGoodsInfo(@Param("goodsId")Integer goodsId);

	public void updateNum(@Param("id")Integer id, @Param("num")long num);
	
	public void updateContent(@Param("id")Integer id, @Param("content")String content);

	public Integer getGoodsTotal(@Param("flag")String flag, @Param("keyword")String keyword, @Param("typeId")String typeId);

	public void updateTotal(@Param("id")Integer goodsId, @Param("quantity")int total);

}
