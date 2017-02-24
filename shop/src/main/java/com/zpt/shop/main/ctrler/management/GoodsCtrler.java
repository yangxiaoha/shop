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
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.Pro;
import com.zpt.shop.main.service.BrandService;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.ProService;

@Controller
@RequestMapping("/management/goods")
public class GoodsCtrler {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private BrandService brandService;
	
	@Autowired
	private ProService proService;
	
	@Autowired
	private GoodsTypeService goodsTypeService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(Integer pageinitGoods){
		ModelAndView mv = new ModelAndView();
		List<Brand> brandList = brandService.getAllBrand();
//		GoodsType goodsType = goodsTypeService.getTypeId(typeId);
		mv.setViewName("/management/goods/index");
		mv.addObject("brandMsg", brandList);
		mv.addObject("pageinitGoodsM",pageinitGoods);
//		mv.addObject("typeMsg", goodsType);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Goods> listData(Query<Goods> query){
		Page<Goods> page = goodsService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Goods goods){
		boolean flag = false;
		try {
			flag = goodsService.validate(goods);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value ="/getPro", method = RequestMethod.POST)
	public List<Pro> getPro(Integer typeId){
		List<Pro> list = null;
		try {
			list = proService.getAllPro(typeId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add",method = RequestMethod.POST )
	public Msg add(Goods goods){
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
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			goodsService.deleteGoods(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.DELETE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.DELTET_LOST);			
			return msg;		
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(Goods goods){
		Msg msg = new Msg();
		try {
			goodsService.updateGoods(goods);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);			
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/stick",method = RequestMethod.POST)
	public Msg stick(Goods goods){
		Msg msg = new Msg();
		try {
			goods.setTop(System.currentTimeMillis());
			goodsService.stickGoods(goods); 
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_GOODS_STICK);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.MSG_GOODS_STICK);
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "/down",method = RequestMethod.POST)
	public Msg down(Goods goods){
		Msg msg = new Msg();
		try {
			goodsService.downGoods(goods); 
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.DOWN_GOODS_STICK);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.MSG_GOODS_DOWN);
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateContent",method = RequestMethod.POST)
	public Msg updateContent(Integer id, String content){
		Msg msg = new Msg();
		try {
			goodsService.updateContent(id,content);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);
			return msg;
		}		
	}
	
	
	@ResponseBody
	@RequestMapping(value ="/getTreeData", method = RequestMethod.POST)
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
}

