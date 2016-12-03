package com.zpt.shop.main.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Sku;

public interface SkuService {
	
	public void insertSku(Sku sku,Integer[] proId,String[] value,HttpServletRequest request, HttpSession session);
	
	public void deleteSku(String ids);
	
	public void updateSku(Sku sku,Integer[] proId,String[] value,HttpServletRequest request, HttpSession session);
	
	public Page<Sku> page(Query<Sku> query);
	
	public boolean validate(Sku sku);
	
	public List<Sku> getSkuByGoods(String goodsId);

	public List<Sku> getGoodsStockInfo(Integer goodsId);
	
	//上传图片到服务器
	public String uploadPhoto(CommonsMultipartFile cmFile, String relaPath);

}
