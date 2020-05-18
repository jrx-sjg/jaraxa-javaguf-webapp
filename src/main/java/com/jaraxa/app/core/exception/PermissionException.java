package com.jaraxa.app.core.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN)
public class PermissionException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public PermissionException() {
		super();
	}

	public PermissionException(String message) {
		super(message);
	}
}
