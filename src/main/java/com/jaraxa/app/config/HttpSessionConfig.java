package com.jaraxa.app.config;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.jaraxa.app.auth.service.AppUserDetailsService;

@Configuration
public class HttpSessionConfig {
	
	private static final Logger logger = LoggerFactory.getLogger(StartupConfig.class);
	
	@Autowired
	private AppUserDetailsService appUserDetailsService;

    @Bean
    public HttpSessionListener httpSessionListener() {
        return new HttpSessionListener() {
            @Override
            public void sessionCreated(HttpSessionEvent se) {
            	String user = null;
            	try {
            		user = appUserDetailsService.getUserContext().getUsername();
            	}catch(Exception e) {
            	}
                logger.info("Session Created with session id {} for user {}", se.getSession().getId(), user);
            }

            @Override
            public void sessionDestroyed(HttpSessionEvent se) {
            	String user = null;
            	try {
            		user = appUserDetailsService.getUserContext().getUsername();
            	}catch(Exception e) {
            	}
            	logger.info("Session Destroyed, Session id {} for user {}", se.getSession().getId(), user);

            }
        };
    }
}