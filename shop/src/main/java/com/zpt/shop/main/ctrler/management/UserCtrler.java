package com.zpt.shop.main.ctrler.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.UserService;

@Controller
@RequestMapping("/management/user")
public class UserCtrler {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public ModelAndView index(Integer userId,Integer temp){
		ModelAndView mv = new ModelAndView();
		if(userId != null){
			User user = userService.getUserId(userId);
			mv.addObject("user", user);
			mv.addObject("id", userId);
			mv.addObject("tempM", temp);			
		}else{
			mv.addObject("id", 0);
			mv.addObject("tempM", 0);
		}
		mv.setViewName("/management/user/index");
		return mv;
	}
	
	@RequestMapping(value="listData",method=RequestMethod.POST)
	@ResponseBody
	public Page<User> listData(Query<User> query,Integer userId){
		if(userId != null && userId != 0){
			query.getObj().setId(userId);
		}else{
			query.getObj().setId(null);
		}
		Page<User> page = userService.page(query);
		return page;
	}
}
