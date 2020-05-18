package com.jaraxa.app.auth.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jaraxa.app.core.web.model.ApiResponse;

public class ApiLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ApiLoginSuccessHandler.class);

	private ObjectMapper objectMapper;

	public ApiLoginSuccessHandler(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		response.setStatus(HttpStatus.OK.value());
		response.setContentType(MediaType.APPLICATION_JSON_VALUE);
		
		ApiResponse<String> apiResponse = new ApiResponse<String>();
		apiResponse.setSuccess(true);
		
		objectMapper.writeValue(response.getOutputStream(), apiResponse);
	}

}
