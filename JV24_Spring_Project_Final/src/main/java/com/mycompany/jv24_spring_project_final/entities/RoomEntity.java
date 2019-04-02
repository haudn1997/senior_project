
package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "room")
public class RoomEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String name;
    
    @OneToMany(mappedBy = "room", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<MovieScheduleEntity> movieSchedule;
    
    @OneToMany(mappedBy = "room", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<SeatLineEntity> seatLine;

    public RoomEntity() {
    }

    public RoomEntity(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<MovieScheduleEntity> getMovieSchedule() {
        return movieSchedule;
    }

    public void setMovieSchedule(List<MovieScheduleEntity> movieSchedule) {
        this.movieSchedule = movieSchedule;
    }

    public List<SeatLineEntity> getSeatLine() {
        return seatLine;
    }

    public void setSeatLine(List<SeatLineEntity> seatLine) {
        this.seatLine = seatLine;
    }
    
    
}
