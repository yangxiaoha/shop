package com.zpt.shop.main.ctrler.management;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.main.entities.AdminUser;
import com.zpt.shop.main.entities.AdminUserMsg;
import com.zpt.shop.main.service.AdminUserMsgService;
import com.zpt.shop.main.service.AdminUserService;

@Controller
@RequestMapping("/management")
public class LoginCtrler {
	
	@Autowired
	private AdminUserService adminUserService;
	
	@Autowired
	private AdminUserMsgService adminUserMsgService;
	
	@RequestMapping(value = "login",method=RequestMethod.GET)
	public String login(){
		return "/management/login";
	}
	
	@RequestMapping(value = "/login",method=RequestMethod.POST)
	public String login(String username,String password,HttpSession session,Map<String,String> map){
		AdminUser adminUser = adminUserService.login(username, password);
		if(adminUser != null){
			session.setAttribute("adminUser", adminUser);
			AdminUser adminUserSession = (AdminUser)session.getAttribute("adminUser");
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String time = dateFormat.format(now);
			String name = adminUserSession.getUsername();
			AdminUserMsg adminUserMsg = new AdminUserMsg();
			adminUserMsg.setTime(time);
			adminUserMsg.setUsername(name);
			adminUserMsgService.insertAdminUserMsg(adminUserMsg);
		
			return Contants.REDIRECT + "/management/goods/index";
			
		}else{
			map.put("msg", Contants.MSG_LOGIN_FAIL);
			return "/management/login";
		}
	}
	
//	@RequestMapping(value="/modify",method=RequestMethod.GET)
//	public String updatePassword() {
//		return "/management/login";
//	}
	
	@ResponseBody
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public Integer updatePassword(String username,String password,String newPassword){
		AdminUser adminUser = adminUserService.selectUser(username, password);
		if (adminUser != null) {
			adminUserService.updatePassword(username, password, newPassword);
			return 1;
			
		}else{			
			return 0;
		}
	}
	
	@RequestMapping("/exit")
	public String exit(HttpSession session){
		session.removeAttribute("adminUser");	
		return Contants.REDIRECT + "login";
	}
}

