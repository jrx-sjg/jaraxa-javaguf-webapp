package com.jaraxa.app.core.service;

import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jaraxa.app.auth.exception.ResourceNotFoundException;
import com.jaraxa.app.config.properties.Properties;

@Service
public class PicturesService {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(PicturesService.class);
	
	private static final String IMAGE_EXTENSION = ".jpg";
	
	@Autowired
	private MinioFileManager fileManager;
	
	@Autowired
	private Properties properties;
	
	public InputStream getById(String group, String id) {
		String repositoryPath = properties.getFilesFolderPaths().getPictures();
		String filePath = repositoryPath + "/" + id + IMAGE_EXTENSION;
		try (InputStream inputStream = fileManager.get(filePath);){
			
			if (inputStream == null) {
				throw new ResourceNotFoundException(filePath, id, null);
			}
			return fileManager.get(filePath);

		} catch (Exception e) {
			throw new ResourceNotFoundException(id, id, e);
		}

	}
}
