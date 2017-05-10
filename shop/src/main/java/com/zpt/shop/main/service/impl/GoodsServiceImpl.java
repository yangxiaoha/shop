package com.zpt.shop.main.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsImages;
import com.zpt.shop.main.mapper.GoodsImagesMapper;
import com.zpt.shop.main.mapper.GoodsMapper;
import com.zpt.shop.main.service.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private GoodsImagesMapper goodsImagesMapper;

	@Override
	public void insertGoods(Goods goods,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		StringBuffer ids = new StringBuffer();
		if(goods.getIdstemp()!= null&&goods.getIdstemp().size()>0){			
			for (int i = 0; i < goods.getIdstemp().size(); i++) {
				ids.append(goods.getIdstemp().get(i));
				if(i != goods.getIdstemp().size() -1){					
					ids.append(",");
				}
			}
		}
		goods.setIds(ids.toString());
		goods.setQuantity(0);
		goodsMapper.insertGoods(goods);
		//转型为MultipartHttpRequest 
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		//创建一个通用的多部分解析器 
		CommonsMultipartFile file = null;
		String[] backPath = new String[3];//上传服务器后返回的值
		int i = 0;
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = (String) it.next();
			file = (CommonsMultipartFile) multipartRequest.getFile(key);//取得上传文件  
			String path = request.getSession().getServletContext().getRealPath("upload");		
			String fileName = file.getOriginalFilename();
			if(file != null){
				backPath[i] = this.uploadPhoto(file, path,i);
				i++;
			}
		}
		if (backPath.length != 0){			
			GoodsImages goodsImages = new GoodsImages();
			goodsImages.setGoodsId(goods.getId());
			goodsImages.setUrl1(backPath[0]);
			goodsImages.setUrl2(backPath[1]);
			goodsImages.setUrl3(backPath[2]);
			goodsImagesMapper.insertImages(goodsImages);
		}		

	}
	
	@Override
	public String uploadPhoto(CommonsMultipartFile cmFile, String relaPath,Integer i) {
		// TODO Auto-generated method stub
		String fileName = null;
		String path = null;
		if (cmFile != null) {
			if (!cmFile.isEmpty()) {
				fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + i + "."
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
	public void deleteGoods(String ids) {
		// TODO Auto-generated method stub
		goodsMapper.deleteGoods(ids);

	}

	@Override
	public void updateGoods(Goods goods,HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		StringBuffer ids = new StringBuffer();
		if(goods.getIdstemp()!= null&&goods.getIdstemp().size()>0){			
			for (int i = 0; i < goods.getIdstemp().size(); i++) {
				ids.append(goods.getIdstemp().get(i));
				if(i != goods.getIdstemp().size() -1){					
					ids.append(",");
				}
			}
		}
		goods.setIds(ids.toString());
		goodsMapper.updateGoods(goods);
		
		//转型为MultipartHttpRequest 
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		//创建一个通用的多部分解析器 
		CommonsMultipartFile file = null;
		String[] backPath = new String[3];//上传服务器后返回的值
		int i = 0;
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			String key = (String) it.next();
			file = (CommonsMultipartFile) multipartRequest.getFile(key);//取得上传文件  
			String path = request.getSession().getServletContext().getRealPath("upload");		
			String fileName = file.getOriginalFilename();
			if(file != null){
				backPath[i] = this.uploadPhoto(file, path,i);
				i++;
			}
		}
		if (backPath.length != 0){			
			GoodsImages goodsImages = new GoodsImages();
			goodsImages.setGoodsId(goods.getId());
			goodsImages.setUrl1(backPath[0]);
			goodsImages.setUrl2(backPath[1]);
			goodsImages.setUrl3(backPath[2]);
			goodsImagesMapper.updateImages(goodsImages);
		}		

	}
	
	@Override
	public void stickGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsMapper.stickGoods(goods);
	}
	
	@Override
	public void downGoods(Goods goods) {
		// TODO Auto-generated method stub
		goodsMapper.downGoods(goods);
	}

	@Override
	public Page<Goods> page(Query<Goods> query) {
		// TODO Auto-generated method stub
		Page<Goods> page = new Page<Goods>();
		String name = query.getOrderName()+" "+query.getOrderDir();
		query.setOrderName("top desc,");
		query.setOrderDir(name);
		List<Goods> list = goodsMapper.listGoods(query);
		Integer count = goodsMapper.countGoods(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Goods goods) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.validate(goods);
		if(list != null && list.size() > 0){
			return false;
		}else{
			return true;			
		}
	}

	@Override
	public List<Goods> getGoodsByBrandId(String brandId) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.getGoodsByBrand(brandId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}
	
	@Override
	public Goods getGoodsId(Integer goodsId) {
		// TODO Auto-generated method stub
		Goods goods = goodsMapper.getGoodsId(goodsId);
		return goods;
	}

	/**
	 * 加载
	 * @param Integer pageStart 开始的下标
	 * @param Integer num 加载条数
	 * @param String flag （最新、人气、现货）
	 * @param String keyword （关键字）
	 * @param String typeId （类型id）
	 * */
	@Override
	public List<Goods> getGoods(Integer pageStart, Integer num, String flag, String keyword, String typeId) {
		//共有多少条数据
		List<Goods> list = goodsMapper.getGoods(pageStart, num);		
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public List<Goods> getGoodsByCondition(Integer pageStart, Integer num, String flag, String keyword, String typeId) {
		// TODO Auto-generated method stub
		List<Goods> list = goodsMapper.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	@Override
	public Goods getGoodsById(Integer goodsId) {
		// TODO Auto-generated method stub
		Goods lowGoods = goodsMapper.getLowGoodsById(goodsId);
		Goods highGoods = goodsMapper.getHighGoodsById(goodsId);
		BigDecimal highPrice = new BigDecimal("0.00");
		highPrice = highGoods.getPrice();
		lowGoods.setHighprice(highPrice);
		return lowGoods;
	}

	@Override
	public List<Goods> getGoodsByTypeId(Integer pageStart, Integer num, String typeId) {
		// TODO Auto-generated method stub
		String flag = "0";
		String keyword = "";
		List<Goods> list = goodsMapper.getGoodsByCondition(pageStart, num, flag, keyword, typeId);
		if(list != null && list.size() > 0){
			return list;
		}else{
			return null;			
		}
	}

	/**
	 * 修改商品购买人数
	 * @param long num 购买人数
	 * */
	@Override
	public void updateNum(Integer id, long num) {
		// TODO Auto-generated method stub
		goodsMapper.updateNum(id, num);
	}

	@Override
	public void updateContent(Integer id, String content) {
		// TODO Auto-generated method stub
		goodsMapper.updateContent(id, content);
	}

	@Override
	public Integer getGoodsTotal(String flag, String keyword, String typeId) {
		// TODO Auto-generated method stub
		Integer total = goodsMapper.getGoodsTotal(flag, keyword, typeId);
		return total;
	}

	@Override
	public void updateTotal(Integer goodsId, int total) {
		// TODO Auto-generated method stub
		goodsMapper.updateTotal(goodsId, total);
	}

	@Override
	public void updateState(Integer id, Integer state) {
		// TODO Auto-generated method stub
		goodsMapper.updateState(id, state);
	}

}
