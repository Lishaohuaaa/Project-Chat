package com.chat.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.chat.pojo.User;
import com.chat.service.UserService;
import com.chat.service.ipml.UserServiceImpl;

public class LoginServlet extends HttpServlet {
	
	private UserService userService = new UserServiceImpl();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		
//		1.获取请求的参数
		String username = new String(req.getParameter("username"));
		String password = req.getParameter("password");
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();

		req.getSession().setAttribute("username",username);
		req.getSession().setAttribute("password",password);
		String data;
		//2.调用XxxService.xxx处理业务、
		User loginUser = userService.login(new User(username, password));
		//如果等于null,说明登陆失败
		if (loginUser == null) {
			System.out.println("用户名[" + username + "]或密码[" + password + "]错误");
			data = "2";
		} else {
			//登录成功
			data = "1";	
		}
		String str = data.toString();
		out.print(str);	
	}
	
}
