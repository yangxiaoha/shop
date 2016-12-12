package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.mapper.GoodsTypeMapper;
import com.zpt.shop.main.service.GoodsTypeService;

@Service
public class GoodsTypeServiceImpl implements GoodsTypeService {

	@Autowired
	private GoodsTypeMapper goodsTypeMapper;
	
	@Override
	public List<GoodsType> selectTypeTree(Integer pid) {
		// TODO Auto-generated method stub
		if(pid == null){
			pid = 0;
		}
		return goodsTypeMapper.selectTypeTree(pid);
	}

	@Override
	public List<GoodsType> getGoodsType() {
		// TODO Auto-generated method stub
		List<GoodsType> list = goodsTypeMapper.getGoodsType();
		if(list != null && list.size() > 0) {
			return list;	
		}else {
			return null;
		}
	}

	@Override
	public Page<GoodsType> page(Query<GoodsType> query) {
		// TODO Auto-generated method stub
		Page<GoodsType> page = new Page<GoodsType>();
		List<GoodsType> list = goodsTypeMapper.listGoodsType(query);
		Integer count = goodsTypeMapper.countGoodsType(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());		
		return page;
	}

	@Override
	public boolean validate(GoodsType goodstype) {
		// TODO Auto-generated method stub
		List<GoodsType> list = goodsTypeMapper.validate(goodstype);
		if (list != null && list.size() > 0) {			
			return false;
		} else {
			return true;
		}
	}

	@Override
	public void insertGoodsType(GoodsType goodstype) {
		// TODO Auto-generated method stub
		goodsTypeMapper.insertGoodsType(goodstype);		
	}

	@Override
	public void deleteGoodsType(String ids) {
		// TODO Auto-generated method stub
		goodsTypeMapper.deleteGoodsType(ids);
		
	}

	@Override
	public void updateGoodsType(GoodsType goodstype) {
		// TODO Auto-generated method stub
		goodsTypeMapper.updateGoodsType(goodstype);
		
	}

	/**
	 * 获取商品类型
	 * */
	@Override
	public List<GoodsType> getType() {
		// TODO Auto-generated method stub
		List<GoodsType> list = goodsTypeMapper.getType();
		if (list != null && list.size() > 0) {			
			return list;
		} else {
			return null;
		}
	}	
}
