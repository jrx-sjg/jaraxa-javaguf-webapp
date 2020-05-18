package com.jaraxa.app.config;


import java.util.Properties;

import javax.sql.DataSource;

import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.matchers.GroupMatcher;
import org.quartz.spi.TriggerFiredBundle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.boot.autoconfigure.quartz.QuartzProperties;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.scheduling.quartz.SpringBeanJobFactory;

@Configuration
public class QuartzConfig {
	
	@Autowired
	private QuartzProperties quartzProperties;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(QuartzConfig.class);

	/**
	 * Creates an specific thread pool for quartz
	 * @return an spring managed thread pool 
	 */
	@Bean
	public ThreadPoolTaskExecutor quartzThreadPoolTaskExecutor() {
		ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
		executor.setCorePoolSize(1);
		executor.setBeanName("quartzThreadPoolTaskExecutor");
		executor.setMaxPoolSize(5);
		executor.setThreadPriority(4);
		executor.setThreadNamePrefix("quartz-absences-");
		return executor;
	}
	
	@Bean
	public SchedulerFactoryBean schedulerFactoryBean(ApplicationContext applicationContext, DataSource dataSource) {
		
		Properties properties = new Properties();
		properties.putAll(quartzProperties.getProperties());
		Long startupDelaySeconds = quartzProperties.getStartupDelay().getSeconds();
		
		SchedulerFactoryBean factoryBean = new SchedulerFactoryBean();
		
		SchedulerJobFactory jobFactory = new SchedulerJobFactory();
		jobFactory.setApplicationContext(applicationContext);
		
		factoryBean.setAutoStartup(quartzProperties.isAutoStartup());
		factoryBean.setDataSource(dataSource);
		factoryBean.setJobFactory(jobFactory);
		factoryBean.setOverwriteExistingJobs(quartzProperties.isOverwriteExistingJobs());
		factoryBean.setSchedulerName(quartzProperties.getSchedulerName());
		factoryBean.setStartupDelay(startupDelaySeconds.intValue());
		factoryBean.setQuartzProperties(properties);
		factoryBean.setTaskExecutor(quartzThreadPoolTaskExecutor());
		factoryBean.setWaitForJobsToCompleteOnShutdown(quartzProperties.isWaitForJobsToCompleteOnShutdown());
		return factoryBean;
	}
	
	@Bean
	public QuartzStartupListener startupListener() {
		return new QuartzStartupListener();
	}
	
	public class QuartzStartupListener {

		@Autowired
		private SchedulerFactoryBean schedulerFactoryBean;
		
		
		@EventListener
		@Order(Ordered.HIGHEST_PRECEDENCE)
		public void onEvent(ApplicationReadyEvent event) throws SchedulerException {
			
//			Scheduler scheduler = schedulerFactoryBean.getScheduler();
//			
//			logger.info("Scheduler - cleanup all jobs and triggers.");
//			
//			for (String groupName : scheduler.getJobGroupNames()) {
//
//				for (JobKey jobKey : scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName))) {
//			    	 
//					logger.info("job {} deleted" , jobKey);
//					scheduler.deleteJob(jobKey);
//				}
//
//		    }
//			logger.info("Scheduler - cleanup finished. Starting scheduler...");
//
//			scheduler.start();
			
		}
		
	}
	
	/**
	 * This class uses the SpringBeanJobFactory to automatically
	 * autowire quartz objects using spring.
	 *
	 */
	public class SchedulerJobFactory extends SpringBeanJobFactory implements ApplicationContextAware {
		 
	    private transient AutowireCapableBeanFactory beanFactory;
	 
	    @Override
	    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
	 
	        beanFactory = applicationContext.getAutowireCapableBeanFactory();
	    }
	 
	    @Override
	    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
	 
	        final Object job = super.createJobInstance(bundle);
	        beanFactory.autowireBean(job);
	        return job;
	    }

	}
	

}
