package com.jaraxa.app.config.properties;

import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.validation.annotation.Validated;

@Validated
public class Properties {
	@NotEmpty private String superadminUsername;
	@NotEmpty private String superadminPassword;
	@NotNull  private Liquibase liquibase;
	@NotNull  private Database database;
	@NotNull  private Schedules schedules;
	@NotNull  private Minio minio;
	private String mockEmailFrom;
	private List<String> mockEmailTo;
	@NotNull private FilesFolderPaths filesFolderPaths;
	
	public String getSuperadminUsername() {return superadminUsername;}
	public void setSuperadminUsername(String superadminUsername) {this.superadminUsername = superadminUsername;}

	public String getSuperadminPassword() {return superadminPassword;}
	public void setSuperadminPassword(String superadminPassword) {this.superadminPassword = superadminPassword;}

	public Liquibase getLiquibase() {return liquibase;}
	public void setLiquibase(Liquibase liquibase) {this.liquibase = liquibase;}

	public Database getDatabase() {return database;}
	public void setDatabase(Database database) {this.database = database;}

	public Schedules getSchedules() { return schedules; }
	public void setSchedules(Schedules schedules) { this.schedules = schedules; }
	
	public Minio getMinio() { return minio; }
	public void setMinio(Minio minio) { this.minio = minio; }
	
	public List<String> getMockEmailTo() { return mockEmailTo; }
	public void setMockEmailTo(List<String> mockEmailTo) { this.mockEmailTo = mockEmailTo; }
	
	public String getMockEmailFrom() { return mockEmailFrom; }
	public void setMockEmailFrom(String mockEmailFrom) { this.mockEmailFrom = mockEmailFrom; }
	
	public FilesFolderPaths getFilesFolderPaths() { return filesFolderPaths; }
	public void setFilesFolderPaths(FilesFolderPaths filesFolderPaths) { this.filesFolderPaths = filesFolderPaths; }
	
	public static class Liquibase{
		private String changeLog;
		private String contexts;

		public String getChangeLog() {return changeLog;}
		public void setChangeLog(String changeLog) {this.changeLog = changeLog;}
		
		public String getContexts() {return contexts;}
		public void setContexts(String contexts) {this.contexts = contexts;}
	}
	
	@Validated
	public static class Database {
		@NotEmpty private String dataSourceClassName;
		@NotEmpty private String type;
		@NotEmpty private String host;
		@NotEmpty private String schema;
		@NotNull  private int port;
		@NotEmpty private String username;
		@NotEmpty private String password;
		@NotNull  private int maxPoolSize;
		@NotEmpty private String createDatabaseIfNotExist;
		
		public String getDataSourceClassName() { return dataSourceClassName; }
		public void setDataSourceClassName(String dataSourceClassName) { this.dataSourceClassName = dataSourceClassName; }

		public String getType() {return type;}
		public void setType(String type) {this.type = type;}
		
		public String getHost() {return host;}
		public void setHost(String host) {this.host = host;}
		
		public String getSchema() {return schema;}
		public void setSchema(String schema) {this.schema = schema;}
		
		public int getPort() {return port;}
		public void setPort(int port) {this.port = port;}
		
		public String getUsername() {return username;}
		public void setUsername(String username) {this.username = username;}
		
		public String getPassword() {return password;}
		public void setPassword(String password) {this.password = password;}
	
		public int getMaxPoolSize() { return maxPoolSize; }
		public void setMaxPoolSize(int maxPoolSize) { this.maxPoolSize = maxPoolSize; }
		
		public String getCreateDatabaseIfNotExist() { return createDatabaseIfNotExist; }
		public void setCreateDatabaseIfNotExist(String createDatabaseIfNotExist) { this.createDatabaseIfNotExist = createDatabaseIfNotExist; }

		@Override
		public String toString() {
			return "Database [driverClassName=" + dataSourceClassName + ", type=" + type + ", host=" + host
					+ ", schema=" + schema + ", port=" + port + ", username=" + username + ", password=" + password
					+ ", maxPoolSize=" + maxPoolSize + "]";
		}
		
	}
	
	@Validated
	public static class Minio {
		private String endPoint;
		private String accessKey;
		private String secretKey;
		private String bucket;
		
		public String getEndPoint() { return endPoint; }
		public void setEndPoint(String endPoint) { this.endPoint = endPoint; }
		
		public String getAccessKey() { return accessKey; }
		public void setAccessKey(String accessKey) { this.accessKey = accessKey; }
		
		public String getSecretKey() { return secretKey; }
		public void setSecretKey(String secretKey) { this.secretKey = secretKey; }
		
		public String getBucket() { return bucket; }
		public void setBucket(String bucket) { this.bucket = bucket; }
	}
	
	@Validated
	public static class Schedules {
		private String schedule;

		public String getSchedule() {return schedule;}
		public void setSchedule(String schedule) {this.schedule = schedule;}
	}
	
	@Validated
	public static class FilesFolderPaths {
		@NotNull private String pictures;
		public String getPictures() {return pictures;}
		public void setPictures(String pictures) {this.pictures = pictures;}
		
		@Override
		public String toString() {
			return "FilesFolderPaths [pictures=" + pictures + "]";
		}
	}
}