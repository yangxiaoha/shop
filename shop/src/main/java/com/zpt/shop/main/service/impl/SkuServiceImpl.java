package com.zpt.shop.main.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Image;
import com.zpt.shop.main.entities.ProVal;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.mapper.ImageMapper;
import com.zpt.shop.main.mapper.ProValMapper;
import com.zpt.shop.main.mapper.SkuMapper;
import com.zpt.shop.main.service.SkuService;


@Service
@Transactional
public class SkuServiceImpl implements SkuService{
	
	@Autowired
	private SkuMapper skuMapper;
	
	@Autowired
	private ProValMapper proValMapper;
	
	@Autowired
	private ImageMapper imageMapper;

	@Override
	public void insertSku(Sku sku,Integer[] proId,String[] value,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		skuMapper.insertSku(sku);
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
		if (backPath != "0"){			
			Image image = new Image();
			image.setSkuId(sku.getId());
			image.setUrl(backPath);
			imageMapper.insertImageUrl(image);
		}		
		List<ProVal> list = new ArrayList<ProVal>();
		for (int i = 0; i < value.length; i++) {
			ProVal proVal = new ProVal();
			proVal.setProId(proId[i]);
			proVal.setSkuId(sku.getId());
			proVal.setValue(value[i]);
			list.add(proVal);
		}
		proValMapper.insertProVal(list);		
	}

	@Override
	public void deleteSku(String ids) {
		// TODO Auto-generated method stub
		skuMapper.deleteSku(ids);
		
	}

	@Override
	public void updateSku(Sku sku,Integer[] proId,String[] value,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		skuMapper.updateSku(sku);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		//创建一个通用的多部分解析器 
		CommonsMultipartFile file = null;
		
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = (String) it.next();
			file = (CommonsMultipartFile) multipartRequest.getFile(key);//取得上传文件  
		}		
		String backPath = null;//上传服务器后返回的值		
		String path = request.getSession().getServletContext().getRealPath("upload");	
		if(file.getSize()>0){			
			String fileName = file.getOriginalFilename();
			if(file != null){
				backPath = this.uploadPhoto(file, path);
			}
			if (backPath != "0"){			
				Image image = new Image();
				image.setSkuId(sku.getId());
				image.setUrl(backPath);
				imageMapper.updateImageUrl(image);
			}
		}
		for (int i = 0; i < value.length; i++) {
			ProVal proVal = new ProVal();
			proVal.setProId(proId[i]);
			proVal.setSkuId(sku.getId());
			proVal.setValue(value[i]);
			proVal.setId(Integer.valueOf(sku.getIds().split(",")[i]).intValue());
			proValMapper.updateProVal(proVal);
		}			
	}

	@Override
	public Page<Sku> page(Query<Sku> query) {
		// TODO Auto-generated method stub
		Page<Sku> page = new Page<>();
		List<Sku> list = skuMapper.listSku(query);
		Integer count = skuMapper.countSku(query);
		page.setAaData(list);
		page.setDraw(query.getDraw());
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		return page;
	}

	@Override
	public boolean validate(Sku sku) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.validate(sku);
		if (list != null && list.size()>0) {
			return false;
		} else {
			return true;
		}		
	}

	@Override
	public List<Sku> getSkuByGoods(String goodsId) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.getSkuByGoods(goodsId);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}
	}

	@Override
	public List<Sku> getGoodsStockInfo(Integer goodsId) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.getGoodsStockInfo(goodsId);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}
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

	@Override
	public List<Sku> getSkuInfoByIds(String skuIds) {
		// TODO Auto-generated method stub
		List<Sku> list = skuMapper.getSkuInfoByIds(skuIds);
		if (list != null && list.size()>0) {
			return list;
		} else {
			return null;
		}
	}

	@Override
	public void updateSkuNum(Integer id, int num) {
		// TODO Auto-generated method stub
		skuMapper.updateSkuNum(id, num);
	}

}
