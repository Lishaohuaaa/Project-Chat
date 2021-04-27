package com.chat.test;

import org.junit.Test;

import com.chat.pojo.User;
import com.chat.service.UserService;
import com.chat.service.ipml.UserServiceImpl;

public class UserServiceTest {

	UserService UserService = new UserServiceImpl();
	
	@Test
	public void testRegistUser() {

		UserService.registUser(new User("李", "1"));
		UserService.registUser(new User("ccc", "cccccc"));
		
	}

	@Test
	public void testLogin() {

		System.out.println(UserService.login(new User("bbb", "bbbbbb")));
			
	}

	@Test
	public void testExistsUsername() {
		
		if (UserService.existsUsername("aaa")) {
			System.out.println("用户名已存在！");
		}else {
			System.out.println("用户名可用！");
		}

	}

}
