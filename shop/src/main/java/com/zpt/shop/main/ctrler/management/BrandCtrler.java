package com.zpt.shop.main.ctrler.management;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Brand;
import com.zpt.shop.main.entities.Supplier;
import com.zpt.shop.main.service.BrandService;
import com.zpt.shop.main.service.SupplierService;

@Controller
@RequestMapping("/management/brand")
public class BrandCtrler {
	
	@Autowired
	private BrandService brandService;
	
	@Autowired
	private SupplierService supplierService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		List<Supplier> supplierList = supplierService.getAllSupplier();
		mv.setViewName("/management/brand/index");
		mv.addObject("supplierMsg", supplierList);
		return mv;
	}	

	@ResponseBody
	@RequestMapping(value="listData",method=RequestMethod.POST)
	public Page<Brand> listData(Query<Brand> query){
		Page<Brand> page = brandService.page(query);
		return page;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/validate",method=RequestMethod.POST)
	public boolean validate(Brand brand){
		boolean flag = false;
		try {
			flag = brandService.validate(brand);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public Msg add(Brand brand){
		Msg msg = new Msg();
		try {
			brandService.insertBrand(brand);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_BRAND_NAME);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			brandService.deleteBrand(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.RETURN_STRING_SUCCESS);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public Msg update(Brand brand){
		Msg msg = new Msg();
		try {
			brandService.updateBrand(brand);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.RETURN_STRING_SUCCESS);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			return msg;
		}
	}

}
