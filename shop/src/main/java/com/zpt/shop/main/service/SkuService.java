package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Sku;

public interface SkuService {
	
	public void insertSku(Sku sku,Integer[] proId,String[] value);
	
	public void deleteSku(String ids);
	
	public void updateSku(Sku sku);
	
	public Page<Sku> page(Query<Sku> query);
	
	public boolean validate(Sku sku);
	
	public List<Sku> getSkuByGoods(String goodsId);

	public List<Sku> getGoodsStockInfo(Integer goodsId);	

}
