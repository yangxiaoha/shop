package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.mapper.GoodsMapper;
import com.zpt.shop.main.mapper.ProValMapper;
import com.zpt.shop.main.mapper.SkuMapper;
import com.zpt.shop.main.service.ProValService;

@Service
public class ProValServiceImpl implements ProValService {
	
	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private SkuMapper skuMapper;
	
	@Autowired
	private ProValMapper proValMapper;

	@Override
	public List<ProVal> getProByTypeId(Integer goodsId) {
		// TODO Auto-generated method stub
		//商品信息
		Goods goods = goodsMapper.getGoodsInfo(goodsId);
		String ids = goods.getIds();
		//skuId
		String skuIds = "";
		List<Sku> skuList = skuMapper.getSkuIdsByGoodsId(goodsId);
		if(skuList != null && skuList.size() > 0) {
			for(int i=0; i<skuList.size(); i++) {
				if(skuIds != null && !("".equals(skuIds))) {
					skuIds = skuIds + "," + skuList.get(i).getId();
				}else {
					skuIds = skuList.get(i).getId().toString();
				}
			}
		}

		List<ProVal> list = proValMapper.getProByTypeId(ids, skuIds);
		if (list != null && list.size() > 0) {			
			return list;
		} else {
			return null;
		}
	}	

}
