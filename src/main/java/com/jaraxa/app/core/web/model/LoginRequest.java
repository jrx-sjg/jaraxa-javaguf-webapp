package com.jaraxa.app.core.web.model;

import javax.validation.constraints.NotEmpty;

import org.springframework.validation.annotation.Validated;

import com.fasterxml.jackson.annotation.JsonProperty;

@Validated
public class LoginRequest {

	@NotEmpty
	@JsonProperty(value="email", required = true)
	private String email;
	
	@NotEmpty
	@JsonProperty(value="password", required=true)
	private String password;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "LoginRequest [email=" + email + ", password=XXXXXXX]";
	}
	
}
