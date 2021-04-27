package com.chat.service.ipml;

import com.chat.dao.UserDao;
import com.chat.dao.ipml.UserDaoImpl;
import com.chat.pojo.User;
import com.chat.service.UserService;

public class UserServiceImpl implements UserService{

	private UserDao UserDao = new UserDaoImpl();
	
	@Override
	public void registUser(User user) {
		// TODO 自动生成的方法存根
		
		UserDao.saveUser(user);
		
	}

	@Override
	public User login(User user) {
		// TODO 自动生成的方法存根
		return UserDao.queryUserByUsernameAndPassword(user.getUsername(), user.getPassword());
	}

	@Override
	public boolean existsUsername(String username) {
		// TODO 自动生成的方法存根
		
		if (UserDao.queryUserByUsername(username) == null) {
			//等于null，说明没查到，没查到表示可用
			return false;			
		}		
		return true;
	}

}
