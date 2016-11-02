package com.zpt.shop.main.ctrler.management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/management")
public class LoginCtrler {
	
	@RequestMapping(value = "login",method=RequestMethod.GET)
	public String login(){
		return "/management/login";
	}

}

