package com.chat.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;

import com.chat.pojo.User;
import com.chat.service.UserService;
import com.chat.service.ipml.UserServiceImpl;

public class RegistServlet extends HttpServlet {
	
	private UserService userService = new UserServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		
//		1.获取请求的参数
		String username = new String(req.getParameter("username"));
		String password = req.getParameter("password");
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		String data;
//		2.检查用户名是否可用
		if (userService.existsUsername(username)) {
			System.out.println("用户名[" + username + "]已存在！");
			data = "2";
		}else {
//		     可用
//            调回Service保存到数据库
			System.out.println("用户名[" + username + "]可用");
			userService.registUser(new User(username, password));
			data = "1";
		}
		String str = data.toString();
		out.print(str);
	}

}
