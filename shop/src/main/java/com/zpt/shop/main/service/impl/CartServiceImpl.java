package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.mapper.CartMapper;
import com.zpt.shop.main.service.CartService;

/**
 * 功能说明:
 *
 * CartServiceImpl.java
 *
 * Original Author: 林敏,2016年11月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;

	@Override
	public Integer addGoodsIntoCart(String userId, String skuId, String num, String price) {
		// TODO Auto-generated method stub
		cartMapper.addGoodsIntoCart(userId, skuId, num, price);
		Integer amount = cartMapper.selectAmount(userId);
		return amount;
	}

	@Override
	public Integer selectAmount(String userId) {
		// TODO Auto-generated method stub
		Integer amount = cartMapper.selectAmount(userId);
		return amount;
	}

	@Override
	public List<Cart> getCartInfo(String userId) {
		// TODO Auto-generated method stub
		List<Cart> list = cartMapper.getCartInfo(userId);
		if(list != null && list.size() > 0) {
			return list;	
		}else {
			return null;
		}
	}

	@Override
	public List<Cart> deleteCartInfo(String userId, String cartId) {
		// TODO Auto-generated method stub
		cartMapper.deleteCartInfo(cartId);
		List<Cart> list = cartMapper.getCartInfo(userId);
		if(list != null && list.size() > 0) {
			return list;	
		}else {
			return null;
		}
	}

}