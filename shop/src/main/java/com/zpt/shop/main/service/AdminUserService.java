package com.zpt.shop.main.service;

import com.zpt.shop.main.entities.AdminUser;

public interface AdminUserService {
	
	public AdminUser login(String username,String password);
	
	public AdminUser selectUser(String username,String password);
	
	public AdminUser updatePassword(String username,String password);

}
