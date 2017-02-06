package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Supplier;
import com.zpt.shop.main.mapper.BrandMapper;
import com.zpt.shop.main.mapper.SupplierMapper;
import com.zpt.shop.main.service.SupplierService;

@Service
public class SupplierServiceImpl implements SupplierService {
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private BrandMapper brandMapper;

	@Override
	public Page<Supplier> page(Query<Supplier> query) {
		// TODO Auto-generated method stub
		List<Supplier> list = supplierMapper.listSupplier(query);
		Integer count = supplierMapper.countSupplier(query);
		Page<Supplier> page = new Page<Supplier>();
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());		
		return page;
	}

	@Override
	public void insertSupplier(Supplier supplier) {
		// TODO Auto-generated method stub
		supplierMapper.insertSupplier(supplier);
		
	}

	@Override
	public boolean validate(Supplier supplier) {
		// TODO Auto-generated method stub
		List<Supplier> list = supplierMapper.validate(supplier);
		if(list!= null&&list.size()>0){
			return false;
		}else{			
			return true;
		}
	}

	@Override
	public void deleteSupplier(String ids) {
		// TODO Auto-generated method stub
		supplierMapper.deleteSupplier(ids);
		brandMapper.deleteBrandinSupplier(ids);
		
	}

	@Override
	public void updateSupplier(Supplier supplier) {
		// TODO Auto-generated method stub
		supplierMapper.updateSupplier(supplier);
		
	}

	@Override
	public List<Supplier> getAllSupplier(String name) {
		// TODO Auto-generated method stub
		List<Supplier> list =  supplierMapper.getAllSupplier(name);
		if(list != null && list.size() > 0){
			return list;
		}
		return null;		
	}

}
