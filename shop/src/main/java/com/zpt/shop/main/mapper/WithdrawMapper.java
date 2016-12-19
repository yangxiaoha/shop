package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Withdraw;

/**
 * 功能说明:
 *
 * WithdrawMapper.java
 *
 * Original Author: 林敏,2016年12月1日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface WithdrawMapper {

	/**
	 * 获取会员信息
	 * @param Integer userId 用户id
	 * */
	public List<Withdraw> getMemberInfo(@Param("userId")Integer userId);

	/**
	 * 获取提现信息
	 * @param Integer userId 用户id
	 * */
	public List<Withdraw> getWithdrawsInfo(@Param("userId")Integer userId);

	/**
	 * 提现申请
	 * */
	public void addWithdrawsInfo(Withdraw withdraw);
	
	public List<Withdraw> listCash(Query<Withdraw> query);
	
	public Integer countCash(Query<Withdraw> query);
	
	public List<Withdraw> validate(Withdraw withdraw);
	
	public void updateState(Withdraw withdraw);

}