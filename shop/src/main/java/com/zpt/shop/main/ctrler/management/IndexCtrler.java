package com.zpt.shop.main.ctrler.management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management")
public class IndexCtrler {

	@RequestMapping("/index")
	public String index(){
		return "/management/index";
	}
}
