package com.zpt.shop.main.ctrler.management;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.baidu.ueditor.ActionEnter;


@Controller
@RequestMapping("/management/ueditor")
public class UeditorCtrler {

	@RequestMapping(value="/upload")
	public void upload(HttpServletRequest request,HttpServletResponse response){
		try {
			request.setCharacterEncoding( "utf-8" );
			response.setHeader("Content-Type" , "text/html");
			response.getWriter().write( new ActionEnter( request, "/upload" ).exec() );
		} catch ( IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
