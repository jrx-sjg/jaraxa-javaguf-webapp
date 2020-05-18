package com.jaraxa.app.core.entities;

import java.util.Set;
import javax.validation.constraints.NotEmpty;

public class User {

	private int id;
	@NotEmpty
	private String userEmail;
	@NotEmpty
	private String password;
	@NotEmpty
	private String lastName;
	@NotEmpty
	private String firstName;
	private Set<Role> roles;
	private boolean active;
	private String lastConnectionDate;
	private String timestamp;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public String getLastConnectionDate() {
		return lastConnectionDate;
	}
	public void setLastConnectionDate(String lastConnectionDate) {
		this.lastConnectionDate = lastConnectionDate;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ", userEmail=" + userEmail + ", password=" + password + ", lastName=" + lastName
				+ ", firstName=" + firstName + ", roles=" + roles + ", active=" + active + ", lastConnectionDate="
				+ lastConnectionDate + ", timestamp=" + timestamp + "]";
	}
}
