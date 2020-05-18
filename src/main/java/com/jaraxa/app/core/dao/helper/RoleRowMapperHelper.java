package com.jaraxa.app.core.dao.helper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import com.jaraxa.app.core.entities.Role;

@Component
public class RoleRowMapperHelper {

	public Set<Role> mapRow ( ResultSet resultSet ) throws SQLException {
		HashSet<Role> roles = new HashSet<Role>();
		for (Role role : Role.values()) {
			String name = role.name().toLowerCase();
			try {
				if (resultSet.getBoolean(name)) {
					roles.add(role);
				}
			} catch (Exception e) {}
		}
		return roles;
	}
}
