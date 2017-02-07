package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Supplier;

public interface SupplierMapper {
	
	public List<Supplier> listSupplier(Query<Supplier> query);
	
	public Integer countSupplier(Query<Supplier> query);
	
	public void insertSupplier(Supplier supplier);
	
	public List<Supplier> validate(Supplier supplier);
	
	public void deleteSupplier(@Param("ids")String ids);
	
	public void updateSupplier(Supplier supplier);
	
	public List<Supplier> getAllSupplier(String name);

}
