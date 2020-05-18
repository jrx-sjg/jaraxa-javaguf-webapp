package com.jaraxa.app.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jaraxa.app.auth.service.AppAuthenticationProvider;
import com.jaraxa.app.auth.service.AppUserDetailsService;
import com.jaraxa.app.auth.web.ApiLoginFailureHandler;
import com.jaraxa.app.auth.web.ApiLoginSuccessHandler;
import com.jaraxa.app.auth.web.AppAuthenticationEntryPoint;
import com.jaraxa.app.auth.web.AppAuthenticationFilter;
import com.jaraxa.app.config.properties.Properties;
import com.jaraxa.app.core.web.model.ApiResponse;


@SuppressWarnings("deprecation")
@EnableWebSecurity
@EnableGlobalMethodSecurity(
        securedEnabled = true,
        jsr250Enabled = true,
        prePostEnabled = true
)
@Configuration
public class SecurityConfig {

	
	/**
	 * API security configuration
	 *
	 */
    @Configuration
    @Order(1)
    public static class ApiWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {
    	
        @Autowired
    	private Properties commonsProperties;
        
        @Autowired
        private ObjectMapper objectMapper;

        @Bean
        public AppAuthenticationEntryPoint unauthorizedHandler() {
        	return new AppAuthenticationEntryPoint();
        }
        
        @Bean
        public Validator validatorFactory() {
            return new LocalValidatorFactoryBean();
        }
        
        @Bean
        public PasswordEncoder passwordEncoder() {
            return NoOpPasswordEncoder.getInstance();
        }

        @Bean
        public ApiLoginSuccessHandler apiLoginSuccessHandler() {
        	return new ApiLoginSuccessHandler(objectMapper);
        }
        
        @Bean 
        public AppAuthenticationProvider authenticationProvider() {
        	return new AppAuthenticationProvider(
        			commonsProperties, 
        			passwordEncoder(), apptUserDetailsService());
        }
        
        @Bean
        public ApiLoginFailureHandler apiLoginFailureHandler() {
        	return new ApiLoginFailureHandler(objectMapper);
        }
        
        @Bean
        public AppUserDetailsService apptUserDetailsService() {
        	return new AppUserDetailsService(commonsProperties);
        }

        @Bean
        @Profile(value = {"develop", "local"})
        public CorsConfigurationSource corsConfigurationSource() {
            UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
            CorsConfiguration corsConfiguration = new CorsConfiguration().applyPermitDefaultValues();
            corsConfiguration.setAllowCredentials(true);
            corsConfiguration.addAllowedMethod(HttpMethod.PUT);
            corsConfiguration.addAllowedMethod(HttpMethod.DELETE);
            source.registerCorsConfiguration("/**", corsConfiguration);
            return source;
        }        

        @Bean
        public AppAuthenticationFilter authenticationFilter() throws Exception {
        	AppAuthenticationFilter filter = new AppAuthenticationFilter(objectMapper, validatorFactory());
            filter.setAuthenticationManager(authenticationManagerBean());
            filter.setFilterProcessesUrl("/api/login");
            filter.setAuthenticationSuccessHandler(apiLoginSuccessHandler());
            filter.setAuthenticationFailureHandler(apiLoginFailureHandler());
            filter.setPostOnly(true);
            return filter;
        }
 
    	@Override
    	protected void configure(HttpSecurity http) throws Exception {
            http
            .cors()
            .and()
            .csrf()
                .disable()
            .exceptionHandling()
                .authenticationEntryPoint(unauthorizedHandler())
            .and()
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            .and()
            .antMatcher("/api/**")
            	.authorizeRequests()
            		.antMatchers("/api/login").permitAll()
            		.antMatchers("/api/users/**").permitAll()
            		.anyRequest().denyAll()
            .and()
            .formLogin()
            .and()
            .logout()
            	.logoutUrl("/api/logout")
            	.logoutSuccessHandler(new LogoutSuccessHandler(){

					@Override
					public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
							Authentication authentication) throws IOException, ServletException {
						ApiResponse<String> apiResponse = new ApiResponse<String>(true, null);
						response.setContentType(MediaType.APPLICATION_JSON_VALUE);
						objectMapper.writeValue(response.getOutputStream(), apiResponse);
					}})
            	.deleteCookies("JSESSIONID")
                .invalidateHttpSession(true);
            
            http.addFilterAt(authenticationFilter(), UsernamePasswordAuthenticationFilter.class);
    	}
    }
    
    /**
     * resources configuration
     *
     */
    @Configuration
    @Order(3)
    public static class ResourcesWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
    	
    	@Override
    	protected void configure(HttpSecurity http) throws Exception {
    		http.csrf().disable()
    			.sessionManagement()
    				.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
    			.and()
    			.authorizeRequests()
	        	.antMatchers(
		        		"/",
		        		"/pictures/**",
				        "/favicon.ico",
				        "/index.html",
				        "/index-min.html",
				        "/css/**",
				        "/fonts/**",
				        "/i18n/**",
				        "/images/**",
				        "/img/**",
				        "/js/**",
				        "/tags/**",
				        "/v2/api-docs",
				        "/swagger**/**",
				        "/webjars/**",
				        "/monitoring/**").permitAll()
	        	.anyRequest().denyAll();
    	}
    }
    
}