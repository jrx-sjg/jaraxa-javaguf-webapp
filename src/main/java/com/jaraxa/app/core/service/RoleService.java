package com.jaraxa.app.core.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.jaraxa.app.core.entities.Role;

@Service
public class RoleService {
	public List<Role> getRoles(){
		List<Role> rolesList = new ArrayList<Role>();
		
		for(Role role : Role.values()) {
			rolesList.add(role);
		}
		
		return rolesList;
	}

	public List<Role> getUsersEnabledRoles(){
		List<Role> rolesList = new ArrayList<Role>();
		
		for(Role role : Role.values()) {
			rolesList.add(role);
		}
		
		return rolesList;
	}
}
