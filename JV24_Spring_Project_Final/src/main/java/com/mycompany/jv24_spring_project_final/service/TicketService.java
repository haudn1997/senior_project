
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity;
import com.mycompany.jv24_spring_project_final.repository.BookTicketRepository;
import com.mycompany.jv24_spring_project_final.repository.MovieScheduleRepository;
import com.mycompany.jv24_spring_project_final.repository.RoomRepository;
import com.mycompany.jv24_spring_project_final.repository.TicketDetailRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketService {

    @Autowired
    private BookTicketRepository bookTicketRepository;
    @Autowired
    private TicketDetailRepository ticketDetailRepository;
    @Autowired
    private MovieScheduleRepository movieScheduleRepository;
    
    @Autowired
    private RoomRepository roomRepository;

    public List<BookTicketEntity> getBookTicket() {
        List<BookTicketEntity> lstticket = (List<BookTicketEntity>) bookTicketRepository.findAll();
        return lstticket;
    }
    public List<TicketDetailEntity> getTicketDetail(){
        return (List<TicketDetailEntity>) ticketDetailRepository.findAll();
    }
    
    public List<MovieScheduleEntity> getMovieSchedule(){
        return (List<MovieScheduleEntity>) movieScheduleRepository.findAll();
    }
    
    public boolean checkExistMovieSchedule(int id){
        return movieScheduleRepository.exists(id);
    }
    public boolean deleteMovieSchedule(int id){
        movieScheduleRepository.delete(id);
        return this.checkExistMovieSchedule(id);
    }
    
    public List<RoomEntity> getRoom(){
        return (List<RoomEntity>) roomRepository.findAll();
    }
    
    public MovieScheduleEntity saveMovieSchedule(MovieScheduleEntity movieSchedule){
        return movieScheduleRepository.save(movieSchedule);
    }
    
    public MovieScheduleEntity findById(int id){
        return movieScheduleRepository.findOne(id);
    }
    
}
