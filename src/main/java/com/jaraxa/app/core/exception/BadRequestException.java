package com.jaraxa.app.core.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class BadRequestException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public BadRequestException() {
		super();
	}

	public BadRequestException(String message) {
		super(message);
	}
}
