package com.zpt.shop.main.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.mapper.ProValMapper;
import com.zpt.shop.main.mapper.SkuMapper;
import com.zpt.shop.main.service.SkuService;


@Service
@Transactional
public class SkuServiceImpl implements SkuService{
	
	@Autowired
	private SkuMapper skuMapper;
	
	@Autowired
	private ProValMapper proValMapper;

	@Override
	public void insertSku(Sku sku,Integer[] proId,String[] value) {
		// TODO Auto-generated method stub
		skuMapper.insertSku(sku);
		List<ProVal> list = new ArrayList<ProVal>();
		for (int i = 0; i < value.length; i++) {
			ProVal proVal = new ProVal();
			proVal.setProId(proId[i]);
			proVal.setSkuId(sku.getId());
			proVal.setValue(value[i]);
			list.add(proVal);
		}		
		proValMapper.insertProVal(list);		
	}

	@Override
	public void deleteSku(String ids) {
		// TODO Auto-generated method stub
		skuMapper.deleteSku(ids);
		
	}

	@Override
	public void updateSku(Sku sku) {
		// TODO Auto-generated method stub
		skuMapper.updateSku(sku);
		
	}

	@Override
	public Page<Sku> page(Query<Sku> query) {
		// TODO Auto-generated method stub
		Page<Sku> page = new Page<>();
		List<Sku> list = skuMapper.listSku(query);
		Integer count = skuMapper.countSku(query);
		page.setAaData(list);
		page.setDraw(query.getDraw());
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		return page;
	}

	@Override
	public boolean validate(Sku sku) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.validate(sku);
		if (list != null && list.size()>0) {
			return false;
		} else {
			return true;
		}		
	}

	@Override
	public List<Sku> getSkuByGoods(String goodsId) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.getSkuByGoods(goodsId);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}
	}

}
