package com.jaraxa.app.management.users.service;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.jaraxa.app.auth.service.AppUserDetailsService;
import com.jaraxa.app.core.dao.UserDao;
import com.jaraxa.app.core.entities.User;
import com.jaraxa.app.management.users.exception.UsersManagementException;
import com.jaraxa.app.management.users.model.UsersManagementConstants;

@Service
public class UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AppUserDetailsService userDetailsService;
	
	public void create(User user) throws UsersManagementException {
		try {
			user.setPassword(encryptPassword(user.getPassword()));
			userDao.create(user);
		}catch(DataAccessException e) {
			logger.error("creating user - user:{} - message:{}", e.getMessage());
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
	}
	
	public void update(int id, User user) throws UsersManagementException {
		try {
			user.setId(id);
			user.setPassword(encryptPassword(user.getPassword()));
			userDao.update(user);
		}catch(DataAccessException e) {
			logger.error("updating user - id={} - message:{}", e.getMessage());
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
	}
	
	public void delete(int id) throws UsersManagementException{
		try {
			userDao.delete(id);
		}catch(DataAccessException e) {
			logger.error("deleting user - id={}", id);
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
		
	}
	
	public List<User> getAll() throws UsersManagementException {
		List<User> users;
		try {
			users = userDao.getAll();
		}catch(DataAccessException e) {
			logger.error("getting all users - message:{}", e.getMessage());
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
		return users;
	}
	
	public User getUser(int id) throws UsersManagementException {
		User user; 
		try {
			user = userDao.getUser(id);
		}catch(DataAccessException e) {
			logger.error("user not found by id={}", id);
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
		
		return user;
	}
	
	public User getByEmail(String email) throws UsersManagementException {
		return getUserByField("user_email", email);
	}
	
	private User getUserByField(String field, String value) throws UsersManagementException {
		User user = null; 
		try {
			user = userDao.getBy(field, value);
		}catch(DataAccessException e) {
			logger.error("user not found by field={} and value={}", field, value);
			throw new UsersManagementException(UsersManagementConstants.RESULT_SQL_ERROR);
		}
		
		return user;
	}
	
	public String encryptPassword(String password) {
		String passwordEncrypted = DigestUtils.md5Hex(password);
		return passwordEncrypted;
	}
	
}
