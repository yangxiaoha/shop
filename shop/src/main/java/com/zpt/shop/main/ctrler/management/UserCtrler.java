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
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.UserService;

@Controller
@RequestMapping("/management/user")
public class UserCtrler {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(){
		return "/management/user/index";
	}
	
	@RequestMapping(value="listData",method=RequestMethod.POST)
	@ResponseBody
	public Page<User> listData(Query<User> query){
		Page<User> page = userService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public Msg add(User user){
		Msg msg = new Msg();
		try{
			userService.insertUser(user);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.RETURN_STRING_SUCCESS);
			return msg;
		}catch(Exception e){
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);
			return msg;
		}
	}
}
