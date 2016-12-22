package com.zpt.shop.main.mapper;

import java.math.BigDecimal;
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

	public void addGoodsIntoCart(@Param("userId")String userId, @Param("skuId")String skuId, @Param("num")Integer num, @Param("price")String price, @Param("totalprice")BigDecimal totalprice);

	public Integer selectAmount(@Param("userId")String userId);

	public List<Cart> getCartInfo(@Param("userId")String userId);

	public void deleteCartInfo(@Param("cartIds")String cartId);

	public Cart selectCart(@Param("userId")String userId, @Param("skuId")String skuId);

	public void updateGoodsIntoCart(@Param("userId")String userId, @Param("skuId")String skuId, @Param("num")Integer num, @Param("price")String price, @Param("totalprice")BigDecimal totalprice);

	public void modifyGoodsIntoCart(@Param("cartId")String cartId, @Param("skuId")String skuId, @Param("num")Integer num, @Param("price")String price, @Param("totalprice")BigDecimal totalprice);

	public List<Cart> getCartByCartIds(@Param("userId")String userId, @Param("cartIds")String cartIds);

	public List<Cart> getCartByCartIdsAndUserId(@Param("userId")Integer userId, @Param("cartIds")String cartIds);

	public List<Cart> getCartInfoById(@Param("cartIds")String cartIds);

}