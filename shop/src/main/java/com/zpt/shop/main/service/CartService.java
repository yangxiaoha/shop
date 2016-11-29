package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.Cart;

public interface CartService {

	/**
	 * 加入购物车
	 * @param String userId 用户id
	 * @param Integer skuId 库存id
	 * */
	public Integer addGoodsIntoCart(String userId, String skuId, String num, String price);

	/**
	 * 购物车数量
	 * @param String userId 用户id
	 * */
	public Integer selectAmount(String userId);

	/**
	 * 购物车信息
	 * @param String userId 用户id
	 * */
	public List<Cart> getCartInfo(String userId);

	/**
	 * 删除购物车
	 * @param String cartId 购物车id
	 * */
	public List<Cart> deleteCartInfo(String userId, String cartId);
	
}
