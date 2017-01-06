package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Brand;

public interface BrandService {
	
	public void insertBrand(Brand brand);
	
	public void deleteBrand(String ids);
	
	public void updateBrand(Brand brand);	
	
	public Page<Brand> page(Query<Brand> query);
	
	public boolean validate(Brand brand);
	
	public List<Brand> getAllBrand();
	
	public List<Brand> getBrandBySupplierId(String supplierId);

	public Brand getBrandById(Integer id);
	
}
