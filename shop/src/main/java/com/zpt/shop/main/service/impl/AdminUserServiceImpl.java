package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.AdminUser;
import com.zpt.shop.main.mapper.AdminUserMapper;
import com.zpt.shop.main.service.AdminUserService;

@Service
public class AdminUserServiceImpl implements AdminUserService {
	
	@Autowired
	private AdminUserMapper adminUserMapper;

	@Override
	public AdminUser login(String username, String password) {
		// TODO Auto-generated method stub
		List<AdminUser> list = adminUserMapper.login(username, password);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public AdminUser selectUser(String username, String password) {
		// TODO Auto-generated method stub
		List<AdminUser> list = adminUserMapper.selectAdminUser(username, password);
		if (list != null && list.size() > 0) {
			return list.get(0);			
		}
		return null;
	}

	@Override
	public AdminUser updatePassword(String username, String password, String newPassword) {
		// TODO Auto-generated method stub
		adminUserMapper.updatePassword(username, password, newPassword);		
		return null;
	}
}
