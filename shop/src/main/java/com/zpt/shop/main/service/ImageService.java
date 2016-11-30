package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Image;

public interface ImageService {
	
	public Page<Image> page(Query<Image> query);
	
	public boolean validate(Image image);

}
