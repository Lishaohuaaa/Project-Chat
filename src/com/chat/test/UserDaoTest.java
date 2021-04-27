package com.chat.test;

import org.junit.Test;

import com.chat.dao.UserDao;
import com.chat.dao.ipml.UserDaoImpl;import com.chat.pojo.User;

public class UserDaoTest {

	UserDao userDao = new UserDaoImpl();
	
	@Test
	public void QueryUserByUsername() {
		      
	
		if(userDao.queryUserByUsername("admin") == null) {
			System.out.println("用户名可用！");
		}else {
			System.out.println("用户名已存在！");
		}
		
	}

	@Test
	public void QueryUserByUsernameAndPassword() {
	
		if(userDao.queryUserByUsernameAndPassword("admin", "admin") == null) {
			System.out.println("用户名或密码错误，登录失败！");
		}else {
			System.out.println("查询成功！");
		}
		
	}

	@Test
	public void SaveUser() {
	
		System.out.println(userDao.saveUser(new User("华", "1")));
		
	}

}
