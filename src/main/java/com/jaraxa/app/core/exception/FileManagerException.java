package com.jaraxa.app.core.exception;

public class FileManagerException extends Exception {

	private static final long serialVersionUID = 1L;

	public FileManagerException(String message) {
		super(message);
	}

	public FileManagerException(String message, Throwable throwable) {
		super(message, throwable);
	}

}
