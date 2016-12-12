package com.zpt.shop.main.ctrler.management;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.GoodsType;
import com.zpt.shop.main.entities.Pro;
import com.zpt.shop.main.service.GoodsTypeService;
import com.zpt.shop.main.service.ProService;

@Controller
@RequestMapping("/management/pro")
public class ProCtrler {
	
	@Autowired
	private ProService proService;
	
	@Autowired
	private GoodsTypeService goodsTypeService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/pro/index";		
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Pro> listData(Query<Pro> query){
		Page<Pro> page = proService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Pro pro){
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
	@RequestMapping(value = "/getTreeData",method = RequestMethod.POST)
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
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	public Msg add(Pro pro){
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
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			proService.deletePro(ids);
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
	public Msg update(Pro pro){
		Msg msg = new Msg();
		try {
			proService.updatePro(pro);
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
}
