package com.zpt.shop.main.mapper;

import java.util.List;

import com.zpt.shop.main.entities.GoodsImages;

public interface GoodsImagesMapper {
	
	public void insertImages(GoodsImages goodsImages);
	
	public void updateImages(GoodsImages goodsImages);
	
	public List<GoodsImages> getGoodsImg(Integer goodsId);

}
