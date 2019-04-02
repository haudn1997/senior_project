
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.UserRoleEntity;
import com.mycompany.jv24_spring_project_final.enums.Role;
import com.mycompany.jv24_spring_project_final.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserRoleService {
    @Autowired
    private UserRoleRepository userRoleRepository;
    
    public UserRoleEntity findByRole(Role role) {
        return userRoleRepository.findByRole(role);
    }
}
