package com.jaraxa.app.auth.web.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jaraxa.app.auth.model.UserContext;
import com.jaraxa.app.core.web.model.ApiResponse;

import springfox.documentation.annotations.ApiIgnore;

@RestController
@RequestMapping("/api")
public class AuthController {

	@GetMapping("/me")
	public ApiResponse<UserContext> me(@ApiIgnore @AuthenticationPrincipal UserContext userContext) {
		
		return new ApiResponse<UserContext>(userContext);
	}
}
