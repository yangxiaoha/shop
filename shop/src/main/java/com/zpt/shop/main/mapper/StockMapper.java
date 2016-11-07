package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Stock;

public interface StockMapper {
	
	public void insertStock(Stock stock);

	public Integer countStock(Query<Stock> query);
	
	public List<Stock> listStock(Query<Stock> query);
	
	public List<Stock> validate(Stock stock);
	

}
