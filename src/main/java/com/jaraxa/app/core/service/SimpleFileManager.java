package com.jaraxa.app.core.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.jaraxa.app.core.exception.FileManagerException;

import io.minio.Result;
import io.minio.messages.Item;


@Component("simpleFileManager")
public class SimpleFileManager  {

	private static final Logger logger = LoggerFactory.getLogger(SimpleFileManager.class);
	
	
	public InputStream get(String sourceFolder, String filename) throws FileManagerException {
		String filePath = sourceFolder + "/" + filename;
		try {
			InputStream inputStream = new FileInputStream(filePath);
			
		    return inputStream;
		} catch(FileNotFoundException e) {
			logger.error("file not found in repository - path:{} - message:{}", filePath, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		} catch(Exception e) {
			logger.error("getting file from repository - path:{} - message:{}", filePath, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
		
	}

	public void save(String pathFolder, String pathFileName, MultipartFile multipartFile) throws FileManagerException {
        // Normalize file name
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        Path path = Paths.get(pathFolder).toAbsolutePath().normalize().resolve(pathFileName);
        try {
            Files.copy(multipartFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        } catch(Exception e) {
        	logger.error("storing file in repository - filepath:{} - repository path:{} - message:{}", fileName, path, e.getMessage());
        	throw new FileManagerException(e.getMessage(), e);
        }
	}

	public void move(String sourceFolder, String sourceFilename, String targetFolder, String targetFilename) {
		String source = sourceFolder + "/" + sourceFilename;
		String target = targetFolder + "/" + targetFilename;
		
		Path sourcePath = Paths.get(source);
        Path targetPath = Paths.get(target);
		
		try {
			Files.copy(sourcePath, targetPath);
			Files.delete(sourcePath);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public Iterable<Result<Item>> list(String sourceFolder, String prefix) throws UnsupportedOperationException {
		// Not implemented, because this is not necessary for this class yet.
		throw new UnsupportedOperationException();
	}

}
