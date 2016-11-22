package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Pro;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.mapper.ProMapper;
import com.zpt.shop.main.mapper.ProValMapper;
import com.zpt.shop.main.service.ProService;
import com.zpt.shop.main.service.ProValService;

@Service
public class ProValServiceImpl implements ProValService {
	
	@Autowired
	private ProValMapper proValMapper;

	@Override
	public List<ProVal> getProByTypeId(Integer typeId) {
		// TODO Auto-generated method stub
		List<ProVal> list = proValMapper.getProByTypeId(typeId);
		if (list != null && list.size() > 0) {			
			return list;
		} else {
			return null;
		}
	}	

}
