
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MovieScheduleRepository extends CrudRepository<MovieScheduleEntity, Integer>{
    List<MovieScheduleEntity> findByMovieAndRoomAndDateAndTimeGreaterThanEqual(MovieEntity movie, RoomEntity room, Date date, Date time);
}
