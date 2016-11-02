package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Brand;
import com.zpt.shop.main.mapper.BrandMapper;
import com.zpt.shop.main.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	
	@Autowired
	private BrandMapper brandMapper;

	@Override
	public void insertBrand(Brand brand) {
		// TODO Auto-generated method stub	
		brandMapper.insertBrand(brand);
		
	}

	@Override
	public void deleteBrand(String ids) {
		// TODO Auto-generated method stub
		brandMapper.deleteBrand(ids);
		
	}

	@Override
	public void updateBrand(Brand brand) {
		// TODO Auto-generated method stub
		brandMapper.updateBrand(brand);
		
	}

	@Override
	public Page<Brand> page(Query<Brand> query) {
		// TODO Auto-generated method stub
		
		Page<Brand> page = new Page<Brand>();
		List<Brand> list = brandMapper.listBrand(query);
		Integer count = brandMapper.countBrand(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());		
		return page;	
	}

	@Override
	public boolean validate(Brand brand) {
		// TODO Auto-generated method stub
		List<Brand> list = brandMapper.validate(brand);
		if(list != null && list.size() > 0){
			return false;
		}
		return true;
	}

	@Override
	public List<Brand> getBrandBySupplierId(String supplierId) {
		// TODO Auto-generated method stub
		List<Brand> list = brandMapper.getBrandBySupplier(supplierId);
		if(list != null && list.size() > 0){
			return list;
		}
		return null;
	}

	@Override
	public List<Brand> getAllBrand() {
		// TODO Auto-generated method stub
		List<Brand> list = brandMapper.getAllBrand();
		if(list != null && list.size() > 0){
			return list;
		}
		return null;
	}

}
