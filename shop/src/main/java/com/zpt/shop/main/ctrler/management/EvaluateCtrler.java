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
import com.zpt.shop.main.entities.Evaluate;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.service.EvaluateService;

@Controller
@RequestMapping("/management/evaluate")
public class EvaluateCtrler {
	
	@Autowired
	private EvaluateService evaluateService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/evaluate/index";	
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Evaluate> listData(Query<Evaluate> query){
		Page<Evaluate> page = evaluateService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			evaluateService.deleteEvaluate(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.DELETE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.DELTET_LOST);		
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "seeOrderAll", method = RequestMethod.POST)
	public List<Order> seeOrderAll(Integer orderId){
		List<Order> list = null;
		try {
			list = evaluateService.seeOrderAll(orderId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;		
	}

}
