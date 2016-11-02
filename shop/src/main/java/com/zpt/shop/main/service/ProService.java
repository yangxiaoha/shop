package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Pro;

public interface ProService {
	
	public void insertPro(Pro pro);
	
	public void deletePro(String ids);
	
	public void updatePro(Pro pro);
	
	public Page<Pro> page(Query<Pro> query);
	
	public boolean validate(Pro pro);	

}
