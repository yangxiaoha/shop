package com.zpt.shop.main.service;

import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Supplier;

public interface SupplierService {
	
	public Page<Supplier> page(Query<Supplier> query);
	
	public void insertSupplier(Supplier supplier);
	
	public boolean validate(Supplier supplier);
	
	public void deleteSupplier(String ids);
	
	public void updateSupplier(Supplier supplier);	
	
	public List<Supplier> getAllSupplier();

}
