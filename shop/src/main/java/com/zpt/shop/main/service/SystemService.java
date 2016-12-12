package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;

import com.zpt.shop.main.entities.System;

public interface SystemService {
	
	public Page<System> page(Query<System> query);
	
	public boolean validate(System system);
		
	public void updateSystem(System system);

}
