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

	public List<Sku> getGoodsStockInfo(@Param("goodsId")Integer goodsId);

	/**
	 * 通过id获取库存信息
	 * @param String skuIds 库存ids
	 * @return List<Sku>
	 * */
	public List<Sku> getSkuInfoByIds(@Param("ids")String skuIds);

	/**
	 * 修改库存数量
	 * @param Integer id 库存id
	 * @param int num 剩余数量
	 * */
	public void updateSkuNum(@Param("id")Integer id, @Param("num")int num);

	/**
	 * 通过商品id获取库存信息
	 * @param Integer goodsId 商品id
	 * @return List<Sku>
	 * */
	public List<Sku> getSkuIdsByGoodsId(@Param("goodsId")Integer goodsId);
	
	public List<Sku> getOrderByOrderNum(@Param("orderNum")String orderNum);

	public List<Sku> getAllGoodsStockInfo();
	
}
