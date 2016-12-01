package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Image;
import com.zpt.shop.main.mapper.ImageMapper;
import com.zpt.shop.main.service.ImageService;

@Service
public class ImageServiceImpl implements ImageService {
	
	@Autowired
	private ImageMapper imageMapper;

	@Override
	public Page<Image> page(Query<Image> query) {
		// TODO Auto-generated method stub
		Page<Image> page = new Page<Image>();
		List<Image> list = imageMapper.listImage(query);
		Integer count = imageMapper.countImage(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Image image) {
		// TODO Auto-generated method stub
		List<Image> list = imageMapper.validate(image);
		if(list != null && list.size() > 0){
			return false;
		}else{
			return true;			
		}		
	}

}
