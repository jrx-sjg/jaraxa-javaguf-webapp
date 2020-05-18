package com.jaraxa.app.management.users.exception;

public class UsersManagementException extends Exception {
	private static final long serialVersionUID = 1L;
	
	private String field;
	
	public UsersManagementException() {
		super();
	}
	
	
	public UsersManagementException(String message) {
		super(message);
	}
	
	public UsersManagementException(String message, String field) {
		super(String.format(message,field));
		this.field = field;
	}
	
	public String getField() {
		return field;
	}
}
