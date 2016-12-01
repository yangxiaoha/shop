package com.zpt.shop.main.ctrler.home;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

/**
 * 功能说明:
 *
 * MemberCtrler.java
 *
 * Original Author: 林敏,2016年11月7日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/member")
public class MemberCtrler {
	
	private static Logger logger = LogManager.getLogger(MemberCtrler.class.getName());
	
	//会员中心
	@RequestMapping(value="/memberCenter", method=RequestMethod.GET)
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("home/member-center");
		return mv;
	}

}