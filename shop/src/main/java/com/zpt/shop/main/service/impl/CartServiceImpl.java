package com.zpt.shop.main.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Cart;
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
	public Integer addGoodsIntoCart(String userId, String skuId, Integer num, String price) {
		// TODO Auto-generated method stub
		// 添加购物车之前先判断之前是否已经有此商品
		Cart cart = cartMapper.selectCart(userId, skuId);
		BigDecimal totalPrice = new BigDecimal("0.00");
        BigDecimal money = new BigDecimal(price);
		totalPrice = money.multiply(new BigDecimal(num));//本次总金额
		if(cart != null && !("".equals(cart))) {
			num = num + cart.getNum();
			totalPrice = totalPrice.add(cart.getTotalprice());//totalPrice=本次总金额+之前的金额
			cartMapper.updateGoodsIntoCart(userId, skuId, num, price, totalPrice);
		}else {
			cartMapper.addGoodsIntoCart(userId, skuId, num, price, totalPrice);
		}	
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
	public List<Cart> getCartInfoById(String cartIds) {
		// TODO Auto-generated method stub
		List<Cart> list = cartMapper.getCartInfoById(cartIds);
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

	@Override
	public List<Cart> modifyGoodsIntoCart(String userId, String cartId, String skuId, Integer num, String price) {
		// TODO Auto-generated method stub
		BigDecimal totalPrice = new BigDecimal("0.0");
        BigDecimal money = new BigDecimal(price);
		totalPrice = money.multiply(new BigDecimal(num));
		cartMapper.modifyGoodsIntoCart(cartId, skuId, num, price, totalPrice);
		List<Cart> list = cartMapper.getCartInfo(userId);
		if(list != null && list.size() > 0) {
			return list;	
		}else {
			return null;
		}
	}

	@Override
	public List<Cart> getCartByCartIds(String userId, String cartIds) {
		// TODO Auto-generated method stub
		List<Cart> list = cartMapper.getCartByCartIds(userId, cartIds);
		if(list != null && list.size() > 0) {
			return list;	
		}else {
			return null;
		}
	}

}