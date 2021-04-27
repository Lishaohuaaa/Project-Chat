package com.chat.dao.ipml;

import com.chat.dao.UserDao;
import com.chat.pojo.User;

public class UserDaoImpl extends BasaDao implements UserDao{

	@Override
	public User queryUserByUsername(String username) {
			
		String sql = "select username,password from xx where username = ?";
				
		return queryForOne(User.class, sql, username);
	}

	
	@Override
	public User queryUserByUsernameAndPassword(String username, String password) {

		String sql = "select username,password from xx where username = ? and password = ?";
		
		return queryForOne(User.class, sql, username, password);
	}

	
	@Override
	public int saveUser(User user) {
		
		String sql = "insert into xx (username,password) values (?,?)";

		return update(sql, user.getUsername(),user.getPassword());
	}

	
}
