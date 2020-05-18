package com.jaraxa.app.auth.web;

import java.util.Collection;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import com.jaraxa.app.core.web.model.LoginRequest;

public class AppAuthenticationToken extends UsernamePasswordAuthenticationToken {

    private static final long serialVersionUID = 1L;
    
    /**
     * Constructor of the authentication token
     * @param principal email of the user
     * @param credentials password
     * @param type the type of login performed ( managers or students )
     */
    public AppAuthenticationToken(Object principal, Object credentials) {
        super(principal, credentials);
    }

    public AppAuthenticationToken(Object principal, Object credentials, Collection<? extends GrantedAuthority> authorities) {
        super(principal, credentials, authorities);
    }
    
    public AppAuthenticationToken(LoginRequest loginRequest) {
    	this(loginRequest.getEmail(), loginRequest.getPassword());
    }
}
