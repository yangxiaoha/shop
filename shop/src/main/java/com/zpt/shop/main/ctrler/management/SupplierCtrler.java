package com.zpt.shop.main.ctrler.management;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Supplier;
import com.zpt.shop.main.service.SupplierService;

@Controller
@RequestMapping("/management/supplier")
public class SupplierCtrler {
	
	private static Logger logger = LogManager.getLogger(SupplierCtrler.class.getName());
	
	@Autowired
	private SupplierService supplierService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/supplier/index";
	}
	
	@RequestMapping(value="listData",method=RequestMethod.POST)
	@ResponseBody
	public Page<Supplier> listData(Query<Supplier> query){
		Page<Supplier> page = supplierService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/validate",method=RequestMethod.POST)
	public boolean validate(Supplier supplier){
		boolean flag = false;
		try {
			flag = supplierService.validate(supplier);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public Msg add(Supplier supplier){
		Msg msg = new Msg();
		try {
			supplierService.insertSupplier(supplier);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUPPLIER_NAME);
			return msg;
			
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.MSG_LOGIN_FAIL);
			return msg;
		}		
		
	}	
	
	@ResponseBody
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			supplierService.deleteSupplier(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.RETURN_STRING_SUCCESS);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			logger.error(e.getMessage());
			return msg;
		}		
		
	}
	
	@ResponseBody
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public Msg update(Supplier supplier){
		Msg msg = new Msg();
		try {
			supplierService.updateSupplier(supplier);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.RETURN_STRING_SUCCESS);	
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			return msg;
		}	
		
	}

}
