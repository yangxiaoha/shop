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
	public void updateIntro(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateIntro(sysvalue);
	}

	@Override
	public System selIntro() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selIntro();
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

	@Override
	public System selLCotton() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selLCotton();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public System selCottonField() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selCottonField();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public System selMedia() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selMedia();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public System selLikeAgent() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selLikeAgent();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public System selContact() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selContact();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public System selProblem() {
		// TODO Auto-generated method stub
		System sys = systemMapper.selProblem();
		if(sys != null){
			return sys;
		}else{
			return null;			
		}
	}

	@Override
	public void updateLCotton(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateLCotton(sysvalue);
	}

	@Override
	public void updateCottonField(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateCottonField(sysvalue);
	}

	@Override
	public void updateMedia(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateMedia(sysvalue);
	}

	@Override
	public void updateLikeAgent(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateLikeAgent(sysvalue);
	}

	@Override
	public void updateContact(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateContact(sysvalue);
	}

	@Override
	public void updateProblem(String sysvalue) {
		// TODO Auto-generated method stub
		systemMapper.updateProblem(sysvalue);
	}

	@Override
	public String getSystem(String string) {
		// TODO Auto-generated method stub
		String sysvalue = systemMapper.getSystem(string);
		return sysvalue;
	}
	
}
