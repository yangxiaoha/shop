package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.Banner;

public interface BannerMapper {
	
	public List<Banner> getAllBanner(); 
	
	public void insertBanner(Banner banner);
	
	public void deleteBanner(@Param("ids")String ids);
	
	public void updateBanner(Banner banner);

}
