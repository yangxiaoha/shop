package com.zpt.shop.main.ctrler.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.main.service.SystemService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.WeixinUtils.RequestMethodEnum;
import com.zpt.shop.main.entities.System;

@Controller
@RequestMapping("/management/userDefined")
public class UserDefinedCtrler {
	
	@Autowired
	private WxMpService wxMpService;
	
	@Autowired
	private SystemService systemService;

	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/userDefined/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "updateDefined",method = RequestMethod.POST)
	public Msg update(String sysvalue){
		Msg msg = new Msg();
		try {
			
			String token = wxMpService.getAccessToken(false);
			String url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+token;
			String responseContent = wxMpService.execute(url, RequestMethodEnum.POST, sysvalue);
			JSONObject jsonObject = JSONObject.parseObject(responseContent);
			if("ok".equals(jsonObject.getString("errmsg"))){
				systemService.updateDefined(sysvalue);
				msg.setState(Contants.RETURN_INT_SUCCESS);
				msg.setMsg(Contants.UPDATE_SUCCESS);
			}else{
				msg.setState(Contants.RETURN_INT_FAIL);
				msg.setMsg(Contants.UPDATE_LOST);
			}
		} catch (Exception e) {
			// TODO: handle exception
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);
		}
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "suserDefined",method = RequestMethod.POST)
	public String suserDefined(){
		System sys = systemService.suserDefined();
		return sys.getSysvalue();
	}
}
