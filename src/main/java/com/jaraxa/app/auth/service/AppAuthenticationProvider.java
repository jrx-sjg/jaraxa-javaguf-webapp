package com.jaraxa.app.auth.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.Assert;

import com.jaraxa.app.auth.model.UserContext;
import com.jaraxa.app.auth.web.AppAuthenticationToken;
import com.jaraxa.app.config.properties.Properties;
import com.jaraxa.app.core.entities.User;
import com.jaraxa.app.management.users.service.UserService;

public class AppAuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {

	
    /**
     * The plaintext password used to perform
     * PasswordEncoder#matches(CharSequence, String)}  on when the user is
     * not found to avoid SEC-2056.
     */
    private static final String USER_NOT_FOUND_PASSWORD = "userNotFoundPassword";

    private static final Logger logger = LoggerFactory.getLogger(AppAuthenticationProvider.class);
    	
    private Properties properties;
        
    private PasswordEncoder passwordEncoder;
    
    private AppUserDetailsService userDetailsService;
    
    @Autowired
    private UserContextHelper userContextHelper;
    
    @Autowired
    private UserService userService;
    
    /**
     * The password used to perform
     * {@link PasswordEncoder#matches(CharSequence, String)} on when the user is
     * not found to avoid SEC-2056. This is necessary, because some
     * {@link PasswordEncoder} implementations will short circuit if the password is not
     * in a valid format.
     */
    @SuppressWarnings("unused")
	private String userNotFoundEncodedPassword;

    public AppAuthenticationProvider(Properties commonsProperties,
    		PasswordEncoder passwordEncoder, AppUserDetailsService userDetailsService) {
    	this.properties = commonsProperties;
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void additionalAuthenticationChecks(UserDetails userDetails, UsernamePasswordAuthenticationToken authentication) 
        throws AuthenticationException {
   
    	/*
        if (authentication.getCredentials() == null) {
            logger.debug("Authentication failed: no credentials provided");
            throw new BadCredentialsException(
                messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"));
        }

        String presentedPassword = authentication.getCredentials()
            .toString();

        if (!passwordEncoder.matches(presentedPassword, userDetails.getPassword())) {
            logger.debug("Authentication failed: password does not match stored value");
            throw new BadCredentialsException(
                messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"));
        }
        */
    }

    @Override
    protected void doAfterPropertiesSet() throws Exception {
    	
        Assert.notNull(this.userDetailsService, "A UserDetailsService must be set");
        
        this.userNotFoundEncodedPassword = this.passwordEncoder.encode(USER_NOT_FOUND_PASSWORD);
    }
    

    @Override
    protected UserDetails retrieveUser(String username, UsernamePasswordAuthenticationToken authentication) 
        throws AuthenticationException {
    	
        AppAuthenticationToken authenticationToken = (AppAuthenticationToken) authentication;
        
        try {
        	// retrieve the login credentials
        	String loginUsername = authenticationToken.getPrincipal().toString();
        	String loginPassword = authenticationToken.getCredentials().toString();
        	
        	// recover the superadmin credentials from the configuration
        	String superAdminUsername = properties.getSuperadminUsername();
        	String superAdminPassword = properties.getSuperadminPassword();
        	
        	if (superAdminUsername.equals(loginUsername)) {
        		if (passwordEncoder.matches(loginPassword, superAdminPassword)) {
        			return userContextHelper.createWithFullAccess(username, username, superAdminPassword);
        		}
        	}
        	
        	User loginUser = userService.getByEmail(loginUsername);
        	if(loginUser != null && loginUser.getPassword().equals(userService.encryptPassword(loginPassword))) {
        		//TODO - add roles and permissions
        		List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
        		UserContext userContext = new UserContext(loginUser, authorities);
        		return userContext;
        	}
           
        } catch (Exception repositoryProblem) {
            throw new InternalAuthenticationServiceException(repositoryProblem.getMessage(), repositoryProblem);
        }

        throw new InternalAuthenticationServiceException("User and/or password is not correct");
    }

    // By supporting both token classes this provider can choose
	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(AppAuthenticationToken.class);
	}

}