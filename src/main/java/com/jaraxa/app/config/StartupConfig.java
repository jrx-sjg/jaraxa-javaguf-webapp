package com.jaraxa.app.config;

import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationContextInitializedEvent;
import org.springframework.boot.context.event.ApplicationEnvironmentPreparedEvent;
import org.springframework.boot.context.event.ApplicationFailedEvent;
import org.springframework.boot.context.event.ApplicationPreparedEvent;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.boot.context.event.ApplicationStartingEvent;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;


@Configuration
public class StartupConfig {

	private static final Logger logger = LoggerFactory.getLogger(StartupConfig.class);

	@Bean
	public StartupConfigListener startupConfigListener() {
		return new StartupConfigListener();
	}
	
	public class StartupConfigListener {
		
		@EventListener(ApplicationContextInitializedEvent.class)
		public void onEvent(ApplicationContextInitializedEvent event) {
			logger.info("ApplicationContextInitializedEvent");
		}
		
		@EventListener(ApplicationEnvironmentPreparedEvent.class)
		public void onEvent(ApplicationEnvironmentPreparedEvent event) {
			logger.info("ApplicationEnvironmentPreparedEvent");
		}
		
		@EventListener(ApplicationFailedEvent.class)
		public void onEvent(ApplicationFailedEvent event) {
			logger.info("ApplicationFailedEvent");
		}
		
		@EventListener(ApplicationPreparedEvent.class)
		public void onEvent(ApplicationPreparedEvent event) {
			logger.info("ApplicationPreparedEvent");
		}
		
		@EventListener(ApplicationReadyEvent.class)
		public void onEvent(ApplicationReadyEvent event) {
			logger.info("ApplicationReadyEvent");
		}
		
		@EventListener(ApplicationStartingEvent.class)
		public void onEvent(ApplicationStartingEvent event) {
			logger.info("ApplicationStartingEvent");
		}

		@EventListener(ApplicationStartedEvent.class)
		public void onEvent(ApplicationStartedEvent event) throws SchedulerException {
			logger.info("ApplicationStartedEvent");
			
		}
		
	}

}
