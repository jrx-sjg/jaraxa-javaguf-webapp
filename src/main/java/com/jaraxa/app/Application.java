package com.jaraxa.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.autoconfigure.ldap.LdapHealthIndicatorAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.thymeleaf.ThymeleafAutoConfiguration;


@SpringBootApplication(exclude = {LdapHealthIndicatorAutoConfiguration.class, ThymeleafAutoConfiguration.class})
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}

