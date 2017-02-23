package com.zpt.shop.main.ctrler.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.System;
import com.zpt.shop.main.service.IntroService;

@Controller
@RequestMapping("/management/intro")
public class IntroCtrler {
	
	@Autowired
	private IntroService introService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/intro/index";	
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<System> listData(Query<System> query){
		Page<System> page = introService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(System system){
		boolean flag = false;
		try {
			flag = introService.validate(system);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(System system){
		Msg msg = new Msg();
		try {
			introService.updateIntro(system);
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
