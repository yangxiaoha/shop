package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;

public interface UserMapper {

	public List<User> listUser(Query<User> query);
	
	public Integer countUser(Query<User> query);
	
	public void insertUser(User user);
}
