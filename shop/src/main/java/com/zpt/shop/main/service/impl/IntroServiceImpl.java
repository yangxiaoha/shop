package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.System;
import com.zpt.shop.main.mapper.IntroMapper;
import com.zpt.shop.main.service.IntroService;

@Service
public class IntroServiceImpl implements IntroService {
	
	@Autowired
	private IntroMapper introMapper;

	@Override
	public Page<System> page(Query<System> query) {
		Page<System> page = new Page<System>();
		List<System> list = introMapper.listIntro(query);
		Integer count = introMapper.countIntro(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(System system) {
		List<System> list = introMapper.validate(system);
		if(list != null && list.size() > 0){
			return false;
		}else{			
			return true;
		}
	}

	@Override
	public void updateIntro(System system) {
		// TODO Auto-generated method stub
		introMapper.updateIntro(system);
	}

}
