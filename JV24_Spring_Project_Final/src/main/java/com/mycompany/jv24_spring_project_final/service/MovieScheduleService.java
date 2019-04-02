
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.repository.MovieScheduleRepository;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MovieScheduleService {
    @Autowired
    private MovieScheduleRepository movieScheduleRepository;
    
    public List<MovieScheduleEntity> findDate(MovieEntity movie, RoomEntity room, Date date) {
        return movieScheduleRepository.findByMovieAndRoomAndDateAndTimeGreaterThanEqual(movie, room, date,new Date());
    }
    
    public MovieScheduleEntity findById(int id) {
        MovieScheduleEntity m = movieScheduleRepository.findOne(id);
        if (m!=null && m.getId()>0) {
            return m;
        } else {
            return new MovieScheduleEntity();
        }
    }
}
