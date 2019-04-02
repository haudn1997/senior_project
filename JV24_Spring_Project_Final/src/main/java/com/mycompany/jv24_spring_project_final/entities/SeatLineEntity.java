
package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "seat_line")
public class SeatLineEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String name;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "room_id")
    private RoomEntity room;
    
    @OneToMany(mappedBy = "seatLine", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<PositionSeatEntity> positionSeat;

    public SeatLineEntity() {
    }

    public SeatLineEntity(int id) {
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

    public RoomEntity getRoom() {
        return room;
    }

    public void setRoom(RoomEntity room) {
        this.room = room;
    }

    public List<PositionSeatEntity> getPositionSeat() {
        return positionSeat;
    }

    public void setPositionSeat(List<PositionSeatEntity> positionSeat) {
        this.positionSeat = positionSeat;
    }
    
    
    
    
}
