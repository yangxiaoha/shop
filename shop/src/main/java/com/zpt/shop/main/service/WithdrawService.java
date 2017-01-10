package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
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

	/**
	 * 提现申请
	 * @param Integer userId 用户id
	 * */
	public List<Withdraw> addWithdrawsInfo(Integer userId, String userName, String money);
	
	public Page<Withdraw> page(Query<Withdraw> query);
	
	public boolean validate(Withdraw withdraw);
	
	//public void updateState(Withdraw withdraw);
}
