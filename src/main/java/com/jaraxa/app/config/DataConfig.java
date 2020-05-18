package com.jaraxa.app.config;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.io.DefaultResourceLoader;

import com.jaraxa.app.config.properties.Properties;
import com.jaraxa.app.config.properties.Properties.Database;
import com.zaxxer.hikari.HikariDataSource;

import liquibase.integration.spring.SpringLiquibase;

@Configuration
public class DataConfig {
	
	private static final Logger logger = LoggerFactory.getLogger(DataConfig.class);
	
	@Autowired
	private Properties properties;
	
	
	@Bean
	public DataSource dataSource() {
		Database database = properties.getDatabase();
		String url = String.format("jdbc:%s://%s:%s;databaseName=%s;",
				     database.getType(), 
				     database.getHost(), 
				     database.getPort(), 
				     database.getSchema());
		HikariDataSource dataSource = new HikariDataSource(); 
	    dataSource.setMaximumPoolSize(database.getMaxPoolSize());
	    dataSource.setDataSourceClassName(database.getDataSourceClassName());
	    dataSource.addDataSourceProperty("url", url);
	    dataSource.addDataSourceProperty("user", database.getUsername());
	    dataSource.addDataSourceProperty("password", database.getPassword());
	    logger.info("Database connection pool created");
	    return dataSource;
	}
	

	@Bean
	@Profile("!test")
	public SpringLiquibase liquibase() {		
		SpringLiquibase liquibase = commonLiquibase();
        liquibase.setDropFirst(false);
        liquibase.setShouldRun(true);
		logger.info("Database version control system started.");
        return liquibase;
	}
	
	
	@Bean
	@Profile("test")
	public SpringLiquibase testingLiquibase() {
		SpringLiquibase liquibase = commonLiquibase();
		liquibase.setDropFirst(true);
		liquibase.setShouldRun(true);
		logger.info("Database version control system started.");
		return liquibase;
	}
	
	private SpringLiquibase commonLiquibase() {
		SpringLiquibase liquibase = new SpringLiquibase();
        liquibase.setResourceLoader(new DefaultResourceLoader());
        liquibase.setDataSource(dataSource());
        liquibase.setChangeLog(properties.getLiquibase().getChangeLog());
        liquibase.setContexts(properties.getLiquibase().getContexts());
        
        return liquibase;
	}
	
  
}
