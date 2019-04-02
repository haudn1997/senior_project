
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.PositionSeatEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.SeatLineEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PositionSeatRepository extends CrudRepository<PositionSeatEntity, Integer>{

    public List<PositionSeatEntity> findBySeatLine(SeatLineEntity s);

}
