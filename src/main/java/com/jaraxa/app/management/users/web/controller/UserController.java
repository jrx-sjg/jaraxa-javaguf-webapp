package com.jaraxa.app.management.users.web.controller;


import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jaraxa.app.core.entities.User;
import com.jaraxa.app.core.web.model.ApiResponse;
import com.jaraxa.app.management.users.exception.UsersManagementException;
import com.jaraxa.app.management.users.service.UserService;

@RestController
@RequestMapping("/api/users")
public class UserController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@PostMapping
	public ApiResponse<User> create(@Valid @RequestBody User user, BindingResult bindingResult) {
		ApiResponse<User> apiResponse = new ApiResponse<User>();
		boolean success = true;
		String message = "";
		
		if(bindingResult.hasErrors()) {
			for(FieldError error : bindingResult.getFieldErrors()){
				message += error.getField() + " " + error.getDefaultMessage() + ";";
			}
			success = false;
		}else {
			try {
				userService.create(user);				
			}catch(UsersManagementException e) {
				success = false;
				message = e.getMessage();
			}
		}
		
		apiResponse.setSuccess(success);
		apiResponse.setMessage(message);
		apiResponse.setData(user);
		
		return apiResponse;
	}
	
	@PutMapping("/{id}")
	public ApiResponse<User> update(@PathVariable("id") int id, @Valid @RequestBody User user, BindingResult bindingResult) {
		ApiResponse<User> apiResponse = new ApiResponse<User>();
		boolean success = true;
		String message = "";
		
		if(bindingResult.hasErrors()) {
			for(FieldError error : bindingResult.getFieldErrors()){
				message += error.getField() + " " + error.getDefaultMessage() + ";";
			}
			success = false;
		}else {
			try {
				userService.update(id, user);				
			}catch(UsersManagementException e) {
				success = false;
				message = e.getMessage();
			}
		}
		
		apiResponse.setSuccess(success);
		apiResponse.setMessage(message);
		apiResponse.setData(user);
		
		return apiResponse;
	}
	
	@DeleteMapping("/{id}")
	public ApiResponse<Integer> delete(@PathVariable("id") int id) {
		ApiResponse<Integer> apiResponse = new ApiResponse<Integer>();
		try {
			userService.delete(id);	
			apiResponse.setSuccess(true);
			apiResponse.setData(id);
			
		}catch(UsersManagementException e) {
			apiResponse.setSuccess(false);
			apiResponse.setMessage(e.getMessage());
		}
		
		return apiResponse;
	}
	
	@GetMapping
	public ApiResponse<List<User>> get() {
		ApiResponse<List<User>> apiResponse = new ApiResponse<List<User>>();
		try {
			List<User> users = userService.getAll();
			apiResponse.setData(users);
			apiResponse.setSuccess(true);
		}catch(UsersManagementException e) {
			apiResponse.setSuccess(false);
			apiResponse.setMessage(e.getMessage());
		}
		
		return apiResponse;
	}
	
	@GetMapping("/{id}")
	public ApiResponse<User> getUser(@PathVariable int id) {
		ApiResponse<User> apiResponse = new ApiResponse<User>();
		try {
			User user = userService.getUser(id);
			apiResponse.setData(user);
			apiResponse.setSuccess(true);
		}catch(UsersManagementException e) {
			apiResponse.setSuccess(false);
			apiResponse.setMessage(e.getMessage());
		}
		
		return apiResponse;
	}
}
