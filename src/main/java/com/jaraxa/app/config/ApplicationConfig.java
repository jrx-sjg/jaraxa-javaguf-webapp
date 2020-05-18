package com.jaraxa.app.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.jaraxa.app.config.properties.Properties;

@Configuration
public class ApplicationConfig {

	@Bean
	@ConfigurationProperties
	public Properties commonsProperties() {
		return new Properties();
	}
	

}
