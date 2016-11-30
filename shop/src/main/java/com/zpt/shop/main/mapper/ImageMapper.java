package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Image;

public interface ImageMapper {
	
	public List<Image> listImage(Query<Image> query);
	
	public Integer countImage(Query<Image> query);
	
	public List<Image> validate(Image image);
	
	public void insertImageUrl(Image image);
	
}
