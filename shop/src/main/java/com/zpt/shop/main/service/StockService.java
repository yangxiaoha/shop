package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Stock;

public interface StockService {
	
	public void insertStock(Stock stock);

	public Page<Stock> page(Query<Stock> query);
	
	public boolean validate(Stock stock);	

}
