package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
