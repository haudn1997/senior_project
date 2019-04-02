
package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "position_seat")
public class PositionSeatEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "number_seat")
    private int numberSeat;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "seat_line_id")
    private SeatLineEntity seatLine;
    
    @OneToMany(mappedBy = "positionSeat", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<BookChairEntity> bookChair;

    public PositionSeatEntity() {
    }

    public PositionSeatEntity(int id) {
        this.id = id;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumberSeat() {
        return numberSeat;
    }

    public void setNumberSeat(int numberSeat) {
        this.numberSeat = numberSeat;
    }

    public SeatLineEntity getSeatLine() {
        return seatLine;
    }

    public void setSeatLine(SeatLineEntity seatLine) {
        this.seatLine = seatLine;
    }

    public List<BookChairEntity> getBookChair() {
        return bookChair;
    }

    public void setBookChair(List<BookChairEntity> bookChair) {
        this.bookChair = bookChair;
    }
    
    
}
