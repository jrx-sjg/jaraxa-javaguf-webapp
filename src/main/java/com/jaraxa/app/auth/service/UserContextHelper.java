package com.jaraxa.app.auth.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import com.jaraxa.app.auth.model.UserContext;
import com.jaraxa.app.core.entities.Role;

/**
 * Creates a UserContext with all the available roles and permissions.
 * 
 * Used to create both superadmin on login and the system user
 * for scheduled processes
 *
 */
@Service
public class UserContextHelper {

	public UserContext createWithFullAccess(String username, String name, String password) {
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		// superadmin has all available roles 
		for (Role role : Role.values()) {
			authorities.add(new SimpleGrantedAuthority(role.getAuthority()));
		}
		
		return new UserContext(0, username, username, password, authorities);
	}

}
