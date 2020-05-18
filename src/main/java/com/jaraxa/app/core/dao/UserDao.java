package com.jaraxa.app.core.dao;


import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.jaraxa.app.core.entities.Role;
import com.jaraxa.app.core.entities.User;

@Repository
@Transactional
public class UserDao extends NamedParameterJdbcDaoSupport {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);
	
	private UserRowMapper userRowMapper;
	private SimpleJdbcInsert simpleJdbcInsert;
	
	@Autowired
	public UserDao(DataSource dataSource, UserRowMapper userRowMapper) {
		setDataSource(dataSource);
		this.userRowMapper = userRowMapper;
	}
	
	@PostConstruct
	private void postConstruct() {
		simpleJdbcInsert = new SimpleJdbcInsert(getDataSource());
		simpleJdbcInsert.withTableName("users").usingGeneratedKeyColumns("id");
	}

	private static final String SQL_UPDATE = 
			"UPDATE users SET password = :password, user_email = :user_email,"
					+ " last_name = :last_name, first_name = :first_name, active = :active"
					+ " WHERE id = :id";
	
	private static final String SQL_DELETE =
			"DELETE FROM users WHERE id = :id";
	
	private static final String SQL_GET_ALL =
			"SELECT * FROM users";
	
	private static final String SQL_GET_USER =
			"SELECT * FROM users WHERE id = :id";
	
	public void create(User user) throws DataAccessException {
		MapSqlParameterSource parameters = createBaseUserParameters(user);
		parameters.addValue("timestamp", new Date());
		
		KeyHolder keyHolder = simpleJdbcInsert.executeAndReturnKeyHolder(parameters);
		user.setId(keyHolder.getKey().intValue());
	}
	
	public void delete(int id) throws DataAccessException {
		SqlParameterSource parameters = new MapSqlParameterSource()
				.addValue("id", id);
		getNamedParameterJdbcTemplate().update(SQL_DELETE, parameters);
	}
	
	public void update(User user) throws DataAccessException{
		MapSqlParameterSource parameters = createBaseUserParameters(user);
		parameters.addValue("id", user.getId());
		
		getNamedParameterJdbcTemplate().update(SQL_UPDATE, parameters);
	}
	
	@Transactional(readOnly = true)
	public List<User> getAll() throws DataAccessException {
		return getNamedParameterJdbcTemplate().query(SQL_GET_ALL, userRowMapper);
	}

	@Transactional(readOnly = true)
	public User getUser(int id) throws DataAccessException {
		User user = new User();
		SqlParameterSource parameters = new MapSqlParameterSource()
				.addValue("id", id);
		
		List<User> users = getNamedParameterJdbcTemplate().query(
				SQL_GET_USER, 
				parameters,
				userRowMapper);
		
		if(users.size() > 0) {
			user = users.get(0);
		}
		
		return user;
	}
	
	
	@Transactional(readOnly = true)
	public User getBy(String field, String value) {
		User user = null;
		String sql = "SELECT * FROM users WHERE " + field + " = :value";
		SqlParameterSource parameters = new MapSqlParameterSource()
				.addValue("value", value);
		
		List<User> users = getNamedParameterJdbcTemplate().query(
				sql, 
				parameters,
				userRowMapper);
		
		if(users.size() > 0) {
			user = users.get(0);
		}
		
		return user;
	}
	
	private MapSqlParameterSource createBaseUserParameters(User user) {
		Set<Role> roles = user.getRoles();
		
		MapSqlParameterSource parameters = new MapSqlParameterSource()
				.addValue("password", user.getPassword())
				.addValue("user_email", user.getUserEmail())
				.addValue("last_name", user.getLastName())
				.addValue("first_name", user.getFirstName())
				.addValue("active", user.isActive());
		
		return parameters;
	}
}
