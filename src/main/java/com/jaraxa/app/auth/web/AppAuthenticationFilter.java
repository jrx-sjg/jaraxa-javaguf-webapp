package com.jaraxa.app.auth.web;

import java.io.IOException;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jaraxa.app.core.web.model.LoginRequest;

public class AppAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AppAuthenticationFilter.class);
	private ObjectMapper objectMapper;
	
	private Validator validator;
	
	public AppAuthenticationFilter(ObjectMapper objectMapper, Validator validator) {
		this.objectMapper = objectMapper;
		this.validator = validator;
	}
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request,  HttpServletResponse response)  throws AuthenticationException { 
		
		final String method = request.getMethod();
		
        if ( !method.equals("POST") ) {
            throw new AuthenticationServiceException("Authentication method not supported: "  + method);
        }
                
        AppAuthenticationToken authorizationToken = getAuthRequest(request);
        
        setDetails(request, authorizationToken);
		
		return getAuthenticationManager().authenticate(authorizationToken);
	}
	
	
	private AppAuthenticationToken getAuthRequest(HttpServletRequest request) throws BadCredentialsException {
		
		LoginRequest loginRequest = null;
		try {
	        final String contentType = request.getHeader(HttpHeaders.CONTENT_TYPE);
	        
	        if ( contentType.startsWith(MediaType.APPLICATION_JSON_VALUE) ) {
				
				// process the login request 
				loginRequest = objectMapper.readValue(request.getInputStream(), LoginRequest.class);
	        	
	        } else if ( contentType.startsWith(MediaType.APPLICATION_FORM_URLENCODED_VALUE) ) {

	        	loginRequest = new LoginRequest();
	        	loginRequest.setEmail(request.getParameter("email"));
	        	loginRequest.setPassword(request.getParameter("password"));
	        	
	        } else {
	        	throw new AuthenticationServiceException("Invalid header content-type: " + contentType);
	        }
			
			// validate the login request 
			Set<ConstraintViolation<LoginRequest>> violations = validator.validate(loginRequest);
			
			
			// check if there are one or more missing or invalid parameters
			if ( !violations.isEmpty() ) {
				throw new BadCredentialsException("There are one or more missing/invalid parameters") ;
			}
			
			logger.info("processing login request body: " + loginRequest);
			
		} catch (JsonParseException e) {
			logger.error(e.getMessage());
			throw new BadCredentialsException("There are one or more invalid parameters");
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
			throw new BadCredentialsException("There are one or more invalid parameters");
		} catch (IOException e) {
			logger.error(e.getMessage());
			throw new BadCredentialsException("There are one or more invalid parameters");
		}
		
		return new AppAuthenticationToken(loginRequest);		
	}
}
