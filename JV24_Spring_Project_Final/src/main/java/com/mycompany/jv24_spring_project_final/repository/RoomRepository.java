
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends CrudRepository<RoomEntity, Integer>{
    
}
