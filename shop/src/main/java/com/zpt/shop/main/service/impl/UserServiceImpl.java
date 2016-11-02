package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
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
	public void insertUser(User user) {
		// TODO Auto-generated method stub
		userMapper.insertUser(user);
	}

}
