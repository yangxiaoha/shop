package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.mapper.WithdrawMapper;
import com.zpt.shop.main.service.WithdrawService;

@Service
public class WithdrawServiceImpl implements WithdrawService {

	@Autowired
	private WithdrawMapper withdrawMapper;

	/**
	 * 获取会员信息
	 * @param Integer userId 用户id
	 * */
	@Override
	public List<Withdraw> getMemberInfo(Integer userId) {
		// TODO Auto-generated method stub
		List<Withdraw> withdrawList = withdrawMapper.getMemberInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

	/**
	 * 获取提现信息
	 * @param Integer userId 用户id
	 * */
	@Override
	public List<Withdraw> getWithdrawsInfo(Integer userId) {
		// TODO Auto-generated method stub
		List<Withdraw> withdrawList = withdrawMapper.getWithdrawsInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

}
