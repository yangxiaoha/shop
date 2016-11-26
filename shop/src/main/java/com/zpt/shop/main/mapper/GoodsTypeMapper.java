package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.GoodsType;

public interface GoodsTypeMapper {

	public List<GoodsType> selectTypeTree(@Param("pid")Integer pid);

	public List<GoodsType> getGoodsType();
	
	public Integer countGoodsType(Query<GoodsType> query);
	
	public List<GoodsType> listGoodsType(Query<GoodsType> query);
	
	public List<GoodsType> validate(GoodsType goodstype);
	
	public void insertGoodsType(GoodsType goodstype);
	
	public void deleteGoodsType(@Param("ids")String ids);
	
	public void updateGoodsType(GoodsType goodstype);
}
