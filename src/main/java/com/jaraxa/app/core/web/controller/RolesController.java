package com.jaraxa.app.core.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jaraxa.app.core.entities.Role;
import com.jaraxa.app.core.service.RoleService;
import com.jaraxa.app.core.web.model.ApiResponse;

@RestController
@RequestMapping("/api/role")
public class RolesController {
	
	@Autowired
	private RoleService roleService;

	@GetMapping
	public ApiResponse<List<Role>> getUsersEnabledRoles() {
		ApiResponse<List<Role>> apiResponse = new ApiResponse<List<Role>>();
		List<Role> rolesList = roleService.getUsersEnabledRoles();
		
		apiResponse.setSuccess(true);
		apiResponse.setData(rolesList);
		
		return apiResponse;
	}
	
}
