package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.mapper.GoodsMapper;
import com.zpt.shop.main.mapper.ProValMapper;
import com.zpt.shop.main.service.ProValService;

@Service
public class ProValServiceImpl implements ProValService {
	
	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private ProValMapper proValMapper;

	@Override
	public List<ProVal> getProByTypeId(Integer goodsId) {
		// TODO Auto-generated method stub
		Goods goods = goodsMapper.getGoodsInfo(goodsId);
		String ids = goods.getIds();
		List<ProVal> list = proValMapper.getProByTypeId(ids);
		if (list != null && list.size() > 0) {			
			return list;
		} else {
			return null;
		}
	}	

}
