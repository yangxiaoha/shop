package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;

public interface UserMapper {

	public List<User> listUser(Query<User> query);
	
	public Integer countUser(Query<User> query);
	
	public User gerUserId(@Param("id")Integer id);

}
