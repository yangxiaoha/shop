package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.Cart;

/**
 * 功能说明:
 *
 * CartMapper.java
 *
 * Original Author: 林敏,2016年11月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface CartMapper {

	public void addGoodsIntoCart(@Param("userId")String userId, @Param("skuId")String skuId,  @Param("num")String num, @Param("price")String price);

	public Integer selectAmount(@Param("userId")String userId);

	public List<Cart> getCartInfo(@Param("userId")String userId);

	public void deleteCartInfo(@Param("cartId")String cartId);

}