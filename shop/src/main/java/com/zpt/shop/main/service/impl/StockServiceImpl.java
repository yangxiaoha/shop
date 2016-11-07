package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Stock;
import com.zpt.shop.main.mapper.StockMapper;
import com.zpt.shop.main.service.StockService;

@Service
public class StockServiceImpl implements StockService {
	
	@Autowired
	private StockMapper stockMapper;

	@Override
	public void insertStock(Stock stock) {
		// TODO Auto-generated method stub
		stockMapper.insertStock(stock);

	}

	@Override
	public Page<Stock> page(Query<Stock> query) {
		// TODO Auto-generated method stub
		Page<Stock> page = new Page<>();
		List<Stock> list = stockMapper.listStock(query);
		Integer count = stockMapper.countStock(query);
		page.setAaData(list);
		page.setDraw(query.getDraw());
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		return page;
	}

	@Override
	public boolean validate(Stock stock) {
		// TODO Auto-generated method stub
		List<Stock> list = stockMapper.validate(stock);
		if (list != null && list.size()>0) {
			return false;
		} else {
			return true;
		}
	}

}
