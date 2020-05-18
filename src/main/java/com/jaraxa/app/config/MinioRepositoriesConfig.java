package com.jaraxa.app.config;

import javax.validation.constraints.NotNull;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.core.io.Resource;
import com.jaraxa.app.core.exception.FileManagerException;
import com.jaraxa.app.core.service.MinioFileManager;

/**
 * Base configuration for all the files repositories
 * 
 * On the application startup all the parameterized folders 
 * in the system configuration files are created in the S3 
 * repository and one dummy file is created on each folder
 * to avoid the dissapearing of the own folder if empty
 *
 */
@Configuration
public class MinioRepositoriesConfig {

	private static final Logger logger = LoggerFactory.getLogger(MinioRepositoriesConfig.class);
	
	@Bean
	public MinioRepositoriesStartupListener minioRepositoriesStartupListener() {
		return new MinioRepositoriesStartupListener();
	}
	
	public class MinioRepositoriesStartupListener {		
		@Autowired
		private MinioFileManager fileManager;
		
		@Value("classpath:minio/dummy.txt")
		@NotNull
		private Resource dummyFile;
		
		@EventListener(classes = {ApplicationReadyEvent.class})
		public void initRepositories() {
			
//			for  ( Specifics campusGroup : campusPropertiesService.getCampusGroups() ) {
//            	String picturesDummyFilePath = campusGroup.getFilesFolderPaths().getPictures() + "/" + dummyFile.getFilename();
//            	
//    			try {
//					fileManager.save(picturesDummyFilePath, dummyFile);
//					logger.info("configuration - repositories and dummy files created");
//				} catch (FileManagerException e) {
//					logger.error("fileupload - {} - error creating dummy file - message:{}", e.getMessage());
//				}
//            	
//            }			
			
		}
		
	}
	
	
	
}
