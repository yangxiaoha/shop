package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.main.entities.GoodsImages;
import com.zpt.shop.main.mapper.GoodsImagesMapper;
import com.zpt.shop.main.service.GoodsImagesService;

@Service
public class GoodsImagesServiceImpl implements GoodsImagesService {
	
	@Autowired
	GoodsImagesMapper goodsImagesMapper;

	@Override
	public List<GoodsImages> getGoodsImg(Integer goodsId) {
		// TODO Auto-generated method stub
		List<GoodsImages> goodsImgList = goodsImagesMapper.getGoodsImg(goodsId);
		if(goodsImgList != null && goodsImgList.size() > 0) {
			return goodsImgList;
		}else {
			return null;
		}
	}

}

