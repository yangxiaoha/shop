package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;

public interface UserService {

	public Page<User> page(Query<User> query); 
	
	public User getUserId(Integer id);

}
