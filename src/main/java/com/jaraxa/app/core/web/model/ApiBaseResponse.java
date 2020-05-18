package com.jaraxa.app.core.web.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect
public class ApiBaseResponse {

	private Boolean success;
	private String message;

	public ApiBaseResponse() {
		success = false;
		message = null;
	}
	
    public ApiBaseResponse(Boolean success) {
        this.success = success;
    }    

	public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }
    
    public String getMessage() {
    	return message;
    }
    
	public void setMessage(String message) {
		this.message = message;
	}
    
}
