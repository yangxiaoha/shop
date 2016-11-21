package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.GoodsType;

public interface GoodsTypeService {

	public List<GoodsType> selectTypeTree(Integer pid);
	
}
