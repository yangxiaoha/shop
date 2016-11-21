package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Pro;
import com.zpt.shop.main.mapper.ProMapper;
import com.zpt.shop.main.service.ProService;

@Service
public class ProServiceImpl implements ProService {
	
	@Autowired
	private ProMapper proMapper;

	@Override
	public void insertPro(Pro pro) {
		// TODO Auto-generated method stub
		proMapper.insertPro(pro);
	}

	@Override
	public void deletePro(String ids) {
		// TODO Auto-generated method stub
		proMapper.deletePro(ids);

	}

	@Override
	public void updatePro(Pro pro) {
		// TODO Auto-generated method stub
		proMapper.updatePro(pro);

	}

	@Override
	public Page<Pro> page(Query<Pro> query) {
		// TODO Auto-generated method stub
		Page<Pro> page = new Page<Pro>();
		List<Pro> list = proMapper.listPro(query);
		Integer count = proMapper.countPro(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Pro pro) {
		// TODO Auto-generated method stub
		List<Pro> list = proMapper.validate(pro);
		if (list != null && list.size() > 0) {			
			return false;
		} else {
			return true;
		}
	}

	@Override
	public List<Pro> getAllPro(Integer typeId) {
		// TODO Auto-generated method stub
		if(typeId == null){
			typeId = 0;
		}
		return proMapper.getAllPro(typeId);
	}

}
