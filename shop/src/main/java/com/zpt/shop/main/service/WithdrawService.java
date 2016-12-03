package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.main.entities.Withdraw;

public interface WithdrawService {
	
	/**
	 * 获取会员信息
	 * @param Integer userId 用户id
	 * */
	public List<Withdraw> getMemberInfo(Integer userId);

	/**
	 * 获取提现信息
	 * @param Integer userId 用户id
	 * */
	public List<Withdraw> getWithdrawsInfo(Integer userId);

}
