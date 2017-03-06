package com.zpt.shop.main.ctrler.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.main.entities.System;
import com.zpt.shop.main.service.SystemService;

@Controller
@RequestMapping("/management/media")
public class MediaCtrler {
	
	@Autowired
	private SystemService systemService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/media/index";	
	}
	
	@ResponseBody
	@RequestMapping(value = "selMedia",method = RequestMethod.POST)
	public String selmedia(){
		System sys = systemService.selMedia();
		return sys.getSysvalue();
	}
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(String sysvalue){
		Msg msg = new Msg();
		try {
			systemService.updateMedia(sysvalue);
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