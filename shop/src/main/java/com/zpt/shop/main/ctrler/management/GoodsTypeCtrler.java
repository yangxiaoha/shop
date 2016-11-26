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
import com.zpt.shop.main.service.GoodsTypeService;

@Controller
@RequestMapping("/management/goodstype")
public class GoodsTypeCtrler {
	
	@Autowired
	private GoodsTypeService goodsTypeService;

	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/goodstype/index";		
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<GoodsType> listData(Query<GoodsType> query){
		Page<GoodsType> page = goodsTypeService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(GoodsType goodstype){
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
	public Msg add(GoodsType goodstype){
		Msg msg = new Msg();
		try {
			goodsTypeService.insertGoodsType(goodstype);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_GOODS_NAME);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.MSG_GOODS_NAME);
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			goodsTypeService.deleteGoodsType(ids);
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
