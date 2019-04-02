
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.SeatLineEntity;
import java.io.Serializable;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SeatLineRepository extends CrudRepository<SeatLineEntity, Integer>{

    public List<SeatLineEntity> findByRoom(RoomEntity room);
    
}
