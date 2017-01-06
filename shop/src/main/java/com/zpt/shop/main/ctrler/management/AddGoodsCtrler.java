package com.zpt.shop.main.ctrler.management;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.Pro;
import com.zpt.shop.main.entities.Supplier;
import com.zpt.shop.main.service.BrandService;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.ProService;
import com.zpt.shop.main.service.SupplierService;

@Controller
@RequestMapping("/management/addGoods")
public class AddGoodsCtrler {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private BrandService brandService;
	
	@Autowired
	private ProService proService;
	
	@Autowired
	private SupplierService supplierService;
	
	@Autowired
	private GoodsTypeService goodsTypeService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/management/addGoods/index");
		
		List<Brand> brandList = brandService.getAllBrand();
		List<Supplier> supplierList = supplierService.getAllSupplier();		
		mv.addObject("brandMsg", brandList);
		mv.addObject("supplierMsg", supplierList);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Goods> listData(Query<Goods> query){
		Page<Goods> page = goodsService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validateBrand",method = RequestMethod.POST)
	public boolean validateBrand(Brand brand){
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
	@RequestMapping(value = "/validateSupplier",method = RequestMethod.POST)
	public boolean validateSupplier(Supplier supplier){
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
	@RequestMapping(value = "/validateType",method = RequestMethod.POST)
	public boolean validateType(GoodsType goodstype){
		boolean flag = false;
		try {
			flag = goodsTypeService.validate(goodstype);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validatePro",method = RequestMethod.POST)
	public boolean validatePro(Pro pro){
		boolean flag = false;
		try {
			flag = proService.validate(pro);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}

	@ResponseBody
	@RequestMapping(value ="/getBrandTree", method = RequestMethod.POST)
	public List<Brand> getBrandTree(String supplierid){
		List<Brand> list = null;
		try {
			if(supplierid == null) {
				list = brandService.getAllBrand();
			}else {
				list = brandService.getBrandBySupplierId(supplierid);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value ="/getSupplierTree", method = RequestMethod.POST)
	public List<Supplier> getSupplierTree(){
		List<Supplier> list = null;
		try {
			list = supplierService.getAllSupplier();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value ="/getTypeTree", method = RequestMethod.POST)
	public List<GoodsType> getTreeData(Integer id){
		List<GoodsType> list = null;
		try {
			list = goodsTypeService.selectTypeTree(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value ="/deleteBrand", method = RequestMethod.POST)
	public void deleteBrand(Integer id){
		String ids = id.toString();
		try {
			brandService.deleteBrand(ids);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@ResponseBody
	@RequestMapping(value ="/deleteSupplier", method = RequestMethod.POST)
	public void deleteSupplier(Integer id){
		String ids = id.toString();
		try {
			supplierService.deleteSupplier(ids);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value ="/deletePro", method = RequestMethod.POST)
	public Map<String,Object> deletePro(Integer typeId, String ids){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Pro> pro = new ArrayList<Pro>();
		try {
			proService.deletePro(ids);
			pro = proService.getAllPro(typeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("proMsg", pro);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value ="/addBrand", method = RequestMethod.POST)
	public Msg addBrand(Brand brand){
		Msg msg = new Msg();
		try {
			brandService.insertBrand(brand);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}
	}

	@ResponseBody
	@RequestMapping(value ="/addSupplier", method = RequestMethod.POST)
	public Msg addSupplier(Supplier supplier){
		Msg msg = new Msg();
		try {
			supplierService.insertSupplier(supplier);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;			
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value ="/addType", method = RequestMethod.POST)
	public Msg addType(GoodsType goodstype){
		Msg msg = new Msg();
		try {
			goodsTypeService.insertGoodsType(goodstype);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/addPro",method = RequestMethod.POST)
	public Msg addPro(Pro pro){
		Msg msg = new Msg();
		try {
			proService.insertPro(pro);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "/addGoods",method = RequestMethod.POST )
	public Msg addGoods(Goods goods){
		Msg msg = new Msg();
		try {
			goods.setTop(System.currentTimeMillis());
			goodsService.insertGoods(goods); 
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value ="/getGoodsPro", method = RequestMethod.POST)
	public Map<String,Object> getGoodsPro(Integer typeId){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Pro> pro = new ArrayList<Pro>();
		try {
			pro = proService.getAllPro(typeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("proMsg", pro);
		return map;
	}
	
}

