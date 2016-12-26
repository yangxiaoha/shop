package com.zpt.shop.main.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.common.pojo.RandomArray;
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

	/**
	 * 提现申请
	 * @param Integer userId 用户id
	 * @param String money 提现金额
	 * */
	@Override
	public List<Withdraw> addWithdrawsInfo(Integer userId, String userName, String money) {
		// TODO Auto-generated method stub
		// 生成编号
		long time = System.currentTimeMillis();
		String str = RandomArray.randomArray(0, 9, 2);
		String cashNum = str + Long.toString(time) + str;
		// 下单时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		Date cashTime = new Date();
		try {
			cashTime = df.parse(df.format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Withdraw withdraw = new Withdraw();
		BigDecimal cashMoney = new BigDecimal(money);
		withdraw.setUsername(userName);
		withdraw.setCashNum(cashNum);
		withdraw.setCashTime(cashTime);
		withdraw.setCashMoney(cashMoney);
		withdraw.setUserId(userId);
		withdraw.setState(1);
		withdrawMapper.addWithdrawsInfo(withdraw);
		List<Withdraw> withdrawList = withdrawMapper.getWithdrawsInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

	@Override
	public Page<Withdraw> page(Query<Withdraw> query) {
		// TODO Auto-generated method stub
		Page<Withdraw> page = new Page<>();
		List<Withdraw> list = withdrawMapper.listCash(query);
		Integer count = withdrawMapper.countCash(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Withdraw withdraw) {
		// TODO Auto-generated method stub
		List<Withdraw> list = withdrawMapper.validate(withdraw);
		if(list != null && list.size()>0){
			return false;
		}
		return true;
	}

	@Override
	public void updateState(Withdraw withdraw) {
		// TODO Auto-generated method stub
		withdrawMapper.updateState(withdraw);
	}

}
