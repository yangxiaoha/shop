package com.zpt.shop.main.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.zpt.shop.main.entities.Banner;
import com.zpt.shop.main.mapper.BannerMapper;
import com.zpt.shop.main.service.BannerService;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {
	
	@Autowired
	private BannerMapper bannerMapper;

	@Override
	public List<Banner> getAllBanner() {
		// TODO Auto-generated method stub
		List<Banner> list = bannerMapper.getAllBanner();
		if(list != null && list.size() > 0){
			return list;
		}
		return null;
	}

	@Override
	public void insertBanner(Banner banner,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		//转型为MultipartHttpRequest 
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		//创建一个通用的多部分解析器 
		CommonsMultipartFile file = null;
		
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = (String) it.next();
			file = (CommonsMultipartFile) multipartRequest.getFile(key);//取得上传文件  
		}		
		String backPath = null;//上传服务器后返回的值		
		String path = request.getSession().getServletContext().getRealPath("upload");		
		String fileName = file.getOriginalFilename();
		if(file != null){
			backPath = this.uploadPhoto(file, path);
		}
		if(backPath != "0"){
			banner.setImage(backPath);
			bannerMapper.insertBanner(banner);
		}		
	}

	@Override
	public void deleteBanner(String ids) {
		// TODO Auto-generated method stub
		bannerMapper.deleteBanner(ids);
		
	}

	@Override
	public void updateBanner(Banner banner,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartFile file = null;
		
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = (String) it.next();
			file = (CommonsMultipartFile) multipartRequest.getFile(key);//取得上传文件  
		}		
		String backPath = null;//上传服务器后返回的值		
		String path = request.getSession().getServletContext().getRealPath("upload");		
		String fileName = file.getOriginalFilename();
		if(file != null){
			backPath = this.uploadPhoto(file, path);
		}
		if (backPath != ""&& backPath!= null){			
			banner.setImage(backPath);
		}
		bannerMapper.updateBanner(banner);
	}

	@Override
	public String uploadPhoto(CommonsMultipartFile cmFile, String relaPath) {
		// TODO Auto-generated method stub
		String fileName = null;
		String path = null;
		if (cmFile != null) {
			if (!cmFile.isEmpty()) {
				fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "."
						+ FilenameUtils.getExtension(cmFile.getOriginalFilename()); 
				File targetFile = new File(relaPath, fileName);
				if (!targetFile.exists()) {
					targetFile.mkdirs();
				}
				// 保存
				try {
					cmFile.transferTo(targetFile);
				} catch (Exception e) {
					e.printStackTrace();
					return "0";
				}
				path = "upload" + "/" + fileName;
			}
		}
		return path;		
	}

}
