
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends CrudRepository<UserEntity, Integer>{
    UserEntity findByEmailAndPassword(String email, String password);
    
    public UserEntity findByEmail(String email);

    public UserEntity findByPassword(String password);
    
    List<UserEntity> findByFullNameLike(String fullname);
}
