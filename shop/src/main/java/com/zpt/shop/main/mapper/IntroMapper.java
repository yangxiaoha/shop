package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.System;

public interface IntroMapper {
	
	public List<System> listIntro(Query<System> query);
	
	public Integer countIntro(Query<System> query);
	
	public List<System> validate(System system);
	
	public void updateIntro(System system);

}
