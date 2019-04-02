package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import java.io.Serializable;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookTicketRepository extends CrudRepository<BookTicketEntity, Integer> {

    List<BookTicketEntity> findByMovieAndMovieScheduleEntity(MovieEntity movieId, MovieScheduleEntity scheduleId);
}
