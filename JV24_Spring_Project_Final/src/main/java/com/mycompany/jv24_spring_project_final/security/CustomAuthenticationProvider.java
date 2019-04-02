
package com.mycompany.jv24_spring_project_final.security;

import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import com.mycompany.jv24_spring_project_final.entities.UserRoleEntity;
import com.mycompany.jv24_spring_project_final.service.UserService;
import java.util.ArrayList;
import java.util.List;
import javafx.beans.property.SimpleListProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider{
    @Autowired
    private UserService userService;

    @Override
    public Authentication authenticate(Authentication a) throws AuthenticationException {
        String email = a.getName();
        String password = a.getCredentials().toString().trim();
        
        if (email!=null && !email.isEmpty() && password!=null && !password.isEmpty()) {
            UserEntity userEntity = userService.findUserByEmailAndPassword(email, password);
            if (userEntity!=null && userEntity.getId()>0) {
                List<GrantedAuthority> authorities = new ArrayList<>();
                
                for (UserRoleEntity userRole : userEntity.getUserRole()) {
                    String roleName = userRole.getRole().toString().trim();
                    authorities.add(new SimpleGrantedAuthority(roleName));
                }
                
                return new UsernamePasswordAuthenticationToken(userEntity, email, authorities);
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public boolean supports(Class<?> authentication) {
        //nhan cai username va password khi minh login
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
    
    
}
