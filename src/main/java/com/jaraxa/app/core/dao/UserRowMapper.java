package com.jaraxa.app.core.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.jaraxa.app.core.dao.helper.RoleRowMapperHelper;
import com.jaraxa.app.core.entities.User;


@Component
public class UserRowMapper implements RowMapper<User> {

	private RoleRowMapperHelper roleRowMapperHelper;

	@Autowired
	public UserRowMapper(RoleRowMapperHelper roleRowMapperHelper) {
		this.roleRowMapperHelper = roleRowMapperHelper;
	}
	
	@Override
	public User mapRow(ResultSet resultSet, int rowNum) throws SQLException {

		User user = new User();
		
		user.setId(resultSet.getInt("id"));
		user.setPassword(resultSet.getString("password"));
		user.setLastName(resultSet.getString("last_name"));
		user.setFirstName(resultSet.getString("first_name"));
		user.setUserEmail(resultSet.getString("user_email"));
		user.setActive(resultSet.getBoolean("active"));
		user.setLastConnectionDate(resultSet.getString("last_connection"));
		user.setTimestamp(resultSet.getString("timestamp"));
		
		user.setRoles(roleRowMapperHelper.mapRow(resultSet));
		
		return user;
	}
}