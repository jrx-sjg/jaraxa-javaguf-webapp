package com.jaraxa.app.core.entities;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
	USER(Value.USER),
	ADMIN(Value.ADMIN);	
	
	private final String authority;
	
	private Role(String authority) {
		this.authority = authority;
	}
	
	@Override
	public String getAuthority() {
		return authority;
	}

	public class Value {
		public static final String USER = "user";
		public static final String ADMIN = "admin";

	}
	
}
