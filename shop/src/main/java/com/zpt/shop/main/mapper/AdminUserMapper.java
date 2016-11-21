package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.AdminUser;

public interface AdminUserMapper {
	
	public List<AdminUser> login(@Param("username") String username,@Param("password") String password);

	public List<AdminUser> selectAdminUser(@Param("username") String username,@Param("password") String password);
	
	public void updatePassword(@Param("username") String username,@Param("password") String password,@Param("newPassword") String newPassword);
}
