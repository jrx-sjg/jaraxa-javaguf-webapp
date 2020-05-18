package com.jaraxa.app.auth.model;

import java.util.Collection;
import java.util.Objects;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jaraxa.app.core.entities.User;

public class UserContext implements UserDetails {

	private static final long serialVersionUID = 1L;

	private Integer id;
	
	private String username;

	private String name;
	
    @JsonIgnore
    private String password;

    private Collection<? extends GrantedAuthority> authorities;
    
    public UserContext(User user, Collection<? extends GrantedAuthority> authorities) {
    	this.id = user.getId();
        this.username = user.getUserEmail();
        this.name = user.getFirstName() + " " + user.getLastName();
        this.password = user.getPassword();
        this.authorities = authorities;
    }

    public UserContext(Integer id, String username, String name, String password, Collection<? extends GrantedAuthority> authorities) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.password = password;
        this.authorities = authorities;
    }

    public Integer getId() {
        return id;
    }

    @Override
    public String getUsername() {
        return username;
    }

    public String getName() {
    	return name;
    }
    
    @Override
    public String getPassword() {
        return password;
    }

	@Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserContext that = (UserContext) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

	@Override
	public String toString() {
		return "UserContext [id=" + id + ", username=" + username + ", name=" + name
				+ ", authorities=" + authorities + "]";
	}
}
