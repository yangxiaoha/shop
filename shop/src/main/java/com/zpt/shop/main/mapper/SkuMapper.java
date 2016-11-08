package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Sku;

public interface SkuMapper {
	
	
	public void insertSku(Sku sku);
	
	public void deleteSku(@Param("ids")String ids);
	
	public void updateSku(Sku sku);
	
	public void updateStock(@Param("num")Integer num,@Param("id")Integer id);
	
	public List<Sku> listSku(Query<Sku> query);
	
	public Integer countSku(Query<Sku> query);
	
	public List<Sku> validate(Sku sku);
	
	public List<Sku> getSkuByGoods(@Param("goods")String goodsId);


}
