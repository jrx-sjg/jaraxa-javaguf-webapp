package com.jaraxa.app.auth.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;

import com.jaraxa.app.auth.model.UserContext;
import com.jaraxa.app.config.properties.Properties;
import com.jaraxa.app.core.dao.UserDao;
import com.jaraxa.app.core.entities.Role;

@SuppressWarnings("unused")
public class AppUserDetailsService {

	private Properties properties;

	@Autowired
	private UserDao userDao;
    
    public AppUserDetailsService(Properties properties) {
    	this.properties = properties;
    }
    
	public boolean hasRole(Role role) {
		UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		for (GrantedAuthority grantedAuthority : userDetails.getAuthorities()) {
			if (grantedAuthority.getAuthority().equals(role.getAuthority())) {
				return true;
			}
		}
		return false;
	}

	public UserContext getUserContext() {
		return (UserContext)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}
	
}