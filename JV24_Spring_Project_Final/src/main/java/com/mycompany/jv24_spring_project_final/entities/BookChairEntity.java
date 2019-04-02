
package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "book_chair")
public class BookChairEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_ticket_id")
    private BookTicketEntity bookTicket;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "position_seat_id")
    private PositionSeatEntity positionSeat;

    public BookChairEntity() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BookTicketEntity getBookTicket() {
        return bookTicket;
    }

    public void setBookTicket(BookTicketEntity bookTicket) {
        this.bookTicket = bookTicket;
    }

    public PositionSeatEntity getPositionSeat() {
        return positionSeat;
    }

    public void setPositionSeat(PositionSeatEntity positionSeat) {
        this.positionSeat = positionSeat;
    }
    
    
}
