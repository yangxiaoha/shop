package com.zpt.shop.main.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.PageQuery;
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
		goods.setQuantity(0);
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
		query.setOrderName("top desc,");
		query.setOrderDir("id desc");
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


	@Override
	public List<Goods> getGoods(Integer pageStart, Integer num) {
		List<Goods> list = goodsMapper.getGoods(pageStart, num);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public List<Goods> getGoodsByCondition(Integer pageStart, Integer num, String flag, String keyword, String typeId) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public Goods getGoodsById(Integer goodsId) {
		// TODO Auto-generated method stub
		Goods lowGoods = goodsMapper.getLowGoodsById(goodsId);
		Goods highGoods = goodsMapper.getHighGoodsById(goodsId);
		BigDecimal highPrice = new BigDecimal("0.00");
		highPrice = highGoods.getPrice();
		lowGoods.setHighprice(highPrice);
		return lowGoods;
	}

	@Override
	public List<Goods> getGoodsByTypeId(Integer pageStart, Integer num, String typeId) {
		// TODO Auto-generated method stub
		String flag = "0";
		String keyword = "";
		List<Goods> list = goodsMapper.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	/**
	 * 修改商品购买人数
	 * @param long num 购买人数
	 * */
	@Override
	public void updateNum(Integer id, long num) {
		// TODO Auto-generated method stub
		goodsMapper.updateNum(id, num);
	}

	@Override
	public void updateContent(Integer id, String content) {
		// TODO Auto-generated method stub
		goodsMapper.updateContent(id, content);
	}

}
