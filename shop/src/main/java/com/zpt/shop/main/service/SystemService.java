package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;

import com.zpt.shop.main.entities.System;

public interface SystemService {
	
	public Page<System> page(Query<System> query);
	
	public boolean validate(System system);
		
	public void updateSystem(System system);
	
	public void updateDefined(String sysvalue);
	
	public System suserDefined();
	
	public void updateIntro(String sysvalue);
	
	public void updateLCotton(String sysvalue);
	
	public void updateCottonField(String sysvalue);
	
	public void updateMedia(String sysvalue);
	
	public void updateLikeAgent(String sysvalue);
	
	public void updateContact(String sysvalue);
	
	public void updateProblem(String sysvalue);
	
	public System selIntro();
	
	public System selLCotton();
	
	public System selCottonField();
	
	public System selMedia();
	
	public System selLikeAgent();
	
	public System selContact();
	
	public System selProblem();

	public String getNotice();

	public String getSystem(String string);

}
