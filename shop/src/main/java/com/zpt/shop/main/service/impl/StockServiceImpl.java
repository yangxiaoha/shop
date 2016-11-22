package com.zpt.shop.main.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Stock;
import com.zpt.shop.main.mapper.SkuMapper;
import com.zpt.shop.main.mapper.StockMapper;
import com.zpt.shop.main.service.StockService;

@Service
public class StockServiceImpl implements StockService {
	
	@Autowired
	private StockMapper stockMapper;
	
	@Autowired
	private SkuMapper skuMapper;

	@Override
	public void insertStock(Integer skuId,Integer num,String batch) {
		// TODO Auto-generated method stub
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String time = dateFormat.format(now);
		Stock stock = new Stock();
		stock.setBatch(batch);
		stock.setNum(num);
		stock.setSkuId(skuId);
		stock.setTtime(time);
//		System.out.println(num);
		stockMapper.insertStock(stock);
		skuMapper.updateStock(num, skuId);
	}

}
