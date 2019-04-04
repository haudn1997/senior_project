
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.common.PasswordUtil;
import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import com.mycompany.jv24_spring_project_final.entities.UserRoleEntity;
import com.mycompany.jv24_spring_project_final.enums.Role;
import com.mycompany.jv24_spring_project_final.repository.UserRepository;
import com.mycompany.jv24_spring_project_final.repository.UserRoleRepository;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserRoleRepository userRoleRepository;
    
    public UserEntity findUserByEmailAndPassword(String email, String password) {
        String hashPassword = PasswordUtil.hashPassword(password);
        return userRepository.findByEmailAndPassword(email, hashPassword);
    }
    
    public List<UserEntity> getUser(){
        return (List<UserEntity>) userRepository.findAll();
        
    }
    
    public UserEntity saveUser(UserEntity user){
        
        return userRepository.save(user);
    }
    public List<UserRoleEntity> getUserRole(){
        
        return (List<UserRoleEntity>) userRoleRepository.findAll();
    }
    
    public List<UserEntity> searchUser( String searchtext){  
        return userRepository.findByFullNameLike("%"+searchtext+"%");
    }
    
    public UserRoleEntity findByRole(Role role){
        return userRoleRepository.findByRole(role);
    }
    
    public UserRoleEntity findByRoleId(int roleId) {
        return userRoleRepository.findById(roleId);
    }
    
    public UserEntity findByIdUser(int id){
        return userRepository.findOne(id);
    }
    
    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public UserEntity save(UserEntity u) {
        return userRepository.save(u);
    }
    
    public UserEntity findByPassword(String password) {
        return userRepository.findByPassword(password);
    }
    
    public boolean checkExistUser(int id){
        return userRepository.exists(id);
    }
    
    public boolean deleteUser(int id){
        userRepository.delete(id);
        return this.checkExistUser(id);
    }
}
