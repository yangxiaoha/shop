package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.mapper.SystemMapper;
import com.zpt.shop.main.service.SystemService;

import com.zpt.shop.main.entities.System;

@Service
public class SystemServiceImpl implements SystemService {
	
	@Autowired
	private SystemMapper systemMapper;

	@Override
	public Page<System> page(Query<System> query) {
		// TODO Auto-generated method stub
		Page<System> page = new Page<System>();
		List<System> list = systemMapper.listSystem(query);
		Integer count = systemMapper.countSystem(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(System system) {
		// TODO Auto-generated method stub
		List<System> list = systemMapper.validate(system);
		if(list != null && list.size() > 0){
			return false;
		}else{			
			return true;
		}
	}

	@Override
	public void updateSystem(System system) {
		// TODO Auto-generated method stub
		systemMapper.updateSystem(system);
	}

	@Override
	public void updateDefined(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateDefined(sysvalue);
	}

	@Override
	public System suserDefined() {
		// TODO Auto-generated method stub
		System sys = systemMapper.suserDefined();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public String getNotice() {
		// TODO Auto-generated method stub
		String notice = systemMapper.getNotice();
		return notice;
	}
	
}
