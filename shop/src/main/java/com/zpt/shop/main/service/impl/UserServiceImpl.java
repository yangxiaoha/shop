package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.mapper.UserMapper;
import com.zpt.shop.main.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public Page<User> page(Query<User> query) {
		// TODO Auto-generated method stub
		List<User> list = userMapper.listUser(query);
		Integer count = userMapper.countUser(query);
		Page<User> page = new Page<User>();
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public User getUserId(Integer id) {
		// TODO Auto-generated method stub
		User user = userMapper.gerUserId(id);
		return user;
	}

	/****************************************************************************/
	/**
	 * 获取分销信息
	 * @param Integer userId 用户id
	 * */
	@Override
	public List<User> getAgentInfoByMyId(Integer userId) {
		// TODO Auto-generated method stub
		List<User> list = userMapper.getAgentInfoByMyId(userId);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}	
	}

	/**
	 * 通过openId获取用户信息
	 * @param String openid 用户openid
	 * */
	@Override
	public User getUserByOpenId(String openid) {
		// TODO Auto-generated method stub
		User user = userMapper.getUserByOpenId(openid);
		return user;
	}

	/**
	 * 添加用户
	 * @param String fromUserName 用户openId
	 * @param String createTime 用户openId
	 * */
	@Override
	public void addUser(String fromUserName, String createTime, String ticket, String money) {
		// TODO Auto-generated method stub
		userMapper.addUser(fromUserName, createTime, ticket, money);
	}

	/**
	 * 获取分销信息
	 * @param String ids 代理人id
	 * */
	@Override
	public List<User> getAgentInfoByIds(String ids) {
		// TODO Auto-generated method stub
		List<User> list = userMapper.getAgentInfoByIds(ids);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}	
	}

}
