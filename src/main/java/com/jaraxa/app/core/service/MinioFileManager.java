package com.jaraxa.app.core.service;

import java.io.InputStream;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jaraxa.app.config.properties.Properties;
import com.jaraxa.app.core.exception.FileManagerException;

import io.minio.MinioClient;
import io.minio.Result;
import io.minio.errors.InvalidBucketNameException;
import io.minio.errors.InvalidEndpointException;
import io.minio.errors.InvalidPortException;
import io.minio.messages.Item;


@Service
public class MinioFileManager {
	
	private static final Logger logger = LoggerFactory.getLogger(MinioFileManager.class);
	
	private static final String CONTENT_TYPE = "application/octet-stream";
	
	@Autowired
	private Properties properties;
	
	@Value("classpath:minio/dummy.txt")
	private Resource dummyFile;
	
	private String endpoint; 
	private String accessKey;
	private String secretKey;
	private String bucket;
	
	private MinioClient minioClient;
	

    @PostConstruct
    public void init() {
    	endpoint = properties.getMinio().getEndPoint();
    	accessKey = properties.getMinio().getAccessKey();
    	secretKey = properties.getMinio().getSecretKey();
    	bucket = properties.getMinio().getBucket();
    	
        try {
        	minioClient = new MinioClient(endpoint, accessKey, secretKey);

            if (minioClient.bucketExists(bucket)) {
                logger.info("s3 repository connected : Using bucket {}", bucket);
            } else {
                logger.info("postConstruction() : No name bucket exists, creating a new one");
                minioClient.makeBucket(bucket);
            }
            
            
        } catch (InvalidEndpointException iee) {
        	logger.error("connecting to s3 repository - invalid endpoint:{}" , endpoint);
        } catch (InvalidPortException ipe) {
        	logger.error("connecting to s3 repository - invalid port:{}", endpoint);
        } catch (InvalidBucketNameException ibne) {
        	logger.error("connecting to s3 repository - invalid bucket name:{}", bucket);
        } catch (Exception e) {
            logger.error("connecting to s3 repository - message:{}", minioClient, e.getMessage());
        }
    }	
    
	/**
	 * Gets a Minio Client
	 * 
	 * @return an authenticated Amazon S3 Client
	 * 
	 */
	private MinioClient getMinioClient() throws FileManagerException {
		try {
			return new MinioClient(endpoint, accessKey, secretKey);
		} catch (Exception e) {
			logger.error("connecting to minio server - invalid endpoint: {} - message:{}", endpoint, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
	}
	
	public InputStream get(String objectName) throws FileManagerException {
		MinioClient minioClient = getMinioClient();

		try {
			minioClient.statObject(bucket, objectName);
			
			return minioClient.getObject(bucket, objectName);
			
		} catch (Exception e) {
			throw new FileManagerException(e.getMessage());
		}
	}

	public void save(String objectName, Resource resource) throws FileManagerException {
		MinioClient minioClient = null;
		
		try ( InputStream inputStream = resource.getInputStream() ) {
			
			minioClient = getMinioClient();
			
			if ( !minioClient.bucketExists(bucket) ) {
				minioClient.makeBucket(bucket);
			}
			
			minioClient.putObject(bucket, objectName, inputStream, null, null, null, CONTENT_TYPE);
			
		} catch(Exception e) {
			logger.error("storing object - path:{}/{} - message:{}", bucket, objectName, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
	}

	public void save(String objectName, MultipartFile multipartFile) throws FileManagerException {
		
		
		MinioClient minioClient = null;
		
		try ( InputStream inputStream = multipartFile.getInputStream() ){
			
			minioClient = getMinioClient();
			
			if (!minioClient.bucketExists(bucket)) {
				minioClient.makeBucket(bucket);
			};
			
			minioClient.putObject(bucket, objectName, inputStream, null, null, null, CONTENT_TYPE);
			
		} catch (Exception e) {
			logger.error("storing object - path:{}/{} - message:{}", bucket, objectName, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
	}
	
	public void move(String sourceObjectName, String objectName) throws FileManagerException {
		MinioClient minioClient = null;
		try {
			minioClient = getMinioClient();
			minioClient.copyObject(bucket, objectName, null, null, bucket, sourceObjectName, null, null);
		} catch (Exception e) {
			logger.error("moving object when copying - source path:{}/{} - target path:{}/{} - message:{}", 
						bucket, sourceObjectName, bucket, objectName, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
		try {
			minioClient.removeObject(bucket, sourceObjectName);
		} catch (Exception e) {
			logger.error("moving object when copying - source:{} - target:{} - message:{}", 
					 	sourceObjectName, objectName, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
			
		}
	}
	
	public Iterable<Result<Item>> list(String prefix) throws FileManagerException {
		MinioClient minioClient = null;
		try {
			minioClient = getMinioClient();
			
			Iterable<Result<Item>> resultItems = 
					minioClient.listObjects(bucket, prefix);
			
			return resultItems;
			
		} catch (Exception e) {
			logger.error("listing objects from repository - prefix:{} - message:{}", prefix, e.getMessage());
			throw new FileManagerException(e.getMessage(), e);
		}
		
	}
	
	public void delete(String sourceObjectName) throws FileManagerException {
		try {
			MinioClient minioClient = getMinioClient();
			minioClient.removeObject(bucket, sourceObjectName);
		}catch(Exception e) {
			logger.error("deleting object from repository: {}", sourceObjectName);
			throw new FileManagerException(e.getMessage(),e);
		}
	}

	
}
