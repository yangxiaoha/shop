package com.zpt.shop.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.zpt.shop.main.entities.Banner;

public interface BannerService {
	
	public List<Banner> getAllBanner();
	
	public void insertBanner(Banner banner,HttpServletRequest request, HttpSession session);
	
	public void deleteBanner(String ids);
	
	public void updateBanner(Banner banner,HttpServletRequest request, HttpSession session);
	
	public String uploadPhoto(CommonsMultipartFile cmFile, String relaPath);
}
