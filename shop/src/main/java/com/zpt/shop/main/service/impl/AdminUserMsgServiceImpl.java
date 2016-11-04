package com.zpt.shop.main.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.AdminUserMsg;
import com.zpt.shop.main.mapper.AdminUserMsgMapper;
import com.zpt.shop.main.service.AdminUserMsgService;

@Service
public class AdminUserMsgServiceImpl implements AdminUserMsgService {
	
	@Autowired
	private AdminUserMsgMapper adminUserMsgMapper;

	@Override
	public void insertAdminUserMsg(AdminUserMsg adminUserMsg) {
		// TODO Auto-generated method stub
		adminUserMsgMapper.insertAdminUserMsg(adminUserMsg);
	}

}
