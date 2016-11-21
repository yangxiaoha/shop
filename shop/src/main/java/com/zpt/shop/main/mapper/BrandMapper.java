package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Brand;


public interface BrandMapper {
	
	public void insertBrand(Brand brand);
	
	public void deleteBrand(@Param("ids")String ids);
	
	public void updateBrand(Brand brand);
	
	public List<Brand> listBrand(Query<Brand> query);
	
	public Integer countBrand(Query<Brand> query);
	
	public List<Brand> validate(Brand brand);
	
	public List<Brand> getAllBrand();
	
	public List<Brand> getBrandBySupplier(@Param("supplierId")String supplierId);	

}
