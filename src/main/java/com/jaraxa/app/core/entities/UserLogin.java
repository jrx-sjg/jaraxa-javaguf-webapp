package com.jaraxa.app.core.entities;

import java.util.Set;

public class UserLogin {

	private String campus;
	private String loginEmail;
	private String userName;
	private String roleType;
	private boolean officer;
	private Set<Role> roles;
	private boolean teacher;

	public String getCampus() {
		return campus;
	}

	public void setCampus(String campus) {
		this.campus = campus;
	}

	public String getLoginEmail() {
		return loginEmail;
	}

	public void setLoginEmail(String loginEmail) {
		this.loginEmail = loginEmail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

	public boolean isOfficer() {
		return officer;
	}

	public void setOfficer(boolean officer) {
		this.officer = officer;
	}

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public boolean isTeacher() {
		return teacher;
	}

	public void setTeacher(boolean teacher) {
		this.teacher = teacher;
	}

	@Override
	public String toString() {
		return "UserLogin [campus=" + campus + ", loginEmail=" + loginEmail + ", userName=" + userName + ", roleType="
				+ roleType + ", officer=" + officer + ", roles=" + roles + ", teacher=" + teacher + "]";
	}

}