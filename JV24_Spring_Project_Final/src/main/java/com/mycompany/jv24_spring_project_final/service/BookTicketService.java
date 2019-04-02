package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.repository.BookTicketRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookTicketService {

    @Autowired
    private BookTicketRepository bookTicketRepository;

    public BookTicketEntity save(BookTicketEntity b) {
        return bookTicketRepository.save(b);
    }

    public List<BookTicketEntity> findBookTicketByMovieIdAndScheduleId(int movieId, int scheduleId) {
        MovieEntity movieEntity = new MovieEntity();
        movieEntity.setId(movieId);
        MovieScheduleEntity scheduleEntity = new MovieScheduleEntity();
        scheduleEntity.setId(scheduleId);
        List<BookTicketEntity> lstBookTicketEntitys = bookTicketRepository.findByMovieAndMovieScheduleEntity(movieEntity, scheduleEntity);
        if (lstBookTicketEntitys == null) {
            lstBookTicketEntitys = new ArrayList<>();
        }
        return lstBookTicketEntitys;
    }
}
