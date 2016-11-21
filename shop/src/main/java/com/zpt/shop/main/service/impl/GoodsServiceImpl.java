package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.mapper.GoodsMapper;
import com.zpt.shop.main.service.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsMapper goodsMapper;

	@Override
	public void insertGoods(Goods goods) {
		// TODO Auto-generated method stub
		StringBuffer ids = new StringBuffer();
		if(goods.getIdstemp()!= null&&goods.getIdstemp().size()>0){			
			for (int i = 0; i < goods.getIdstemp().size(); i++) {
				ids.append(goods.getIdstemp().get(i));
				if(i != goods.getIdstemp().size() -1){					
					ids.append(",");
				}
			}
		}
		goods.setIds(ids.toString());
		goodsMapper.insertGoods(goods);

	}

	@Override
	public void deleteGoods(String ids) {
		// TODO Auto-generated method stub
		goodsMapper.deleteGoods(ids);

	}

	@Override
	public void updateGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsMapper.updateGoods(goods);

	}
	
	@Override
	public void stickGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsMapper.stickGoods(goods);
	}

	@Override
	public Page<Goods> page(Query<Goods> query) {
		// TODO Auto-generated method stub
		Page<Goods> page = new Page<Goods>();
		query.setOrderName("top");
		query.setOrderDir("desc");
		List<Goods> list = goodsMapper.listGoods(query);
		Integer count = goodsMapper.countGoods(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Goods goods) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.validate(goods);
		if(list != null && list.size() > 0){
			return false;
		}else{
			return true;			
		}
	}

	@Override
	public List<Goods> getGoodsByBrandId(String brandId) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.getGoodsByBrand(brandId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public Goods getGoodsId(Integer goodsId) {
		// TODO Auto-generated method stub
		Goods goods = goodsMapper.getGoodsId(goodsId);		
		return goods;		
		
	}

}
