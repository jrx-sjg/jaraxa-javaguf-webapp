package com.jaraxa.app.core.web.model;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect
public class ApiResponse<T> extends ApiBaseResponse {

	private T data;

	public ApiResponse() {
		super();
		data = null;
	}
	
    public ApiResponse(Boolean success, T data) {
        super(success);
        this.data = data;
    }

    public ApiResponse(T data) {
    	super(true);
    	this.data = data;
	}
    
    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }    
}
