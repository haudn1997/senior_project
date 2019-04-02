
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
@Table(name = "ticket_detail")
public class TicketDetailEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private int quantity;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_ticket_id")
    private BookTicketEntity bookTicket;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_ticket_id")
    private CategoryTicketEntity categoryTicket;

    public TicketDetailEntity() {
    }

    public TicketDetailEntity(int id) {
        this.id = id;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BookTicketEntity getBookTicket() {
        return bookTicket;
    }

    public void setBookTicket(BookTicketEntity bookTicket) {
        this.bookTicket = bookTicket;
    }

    public CategoryTicketEntity getCategoryTicket() {
        return categoryTicket;
    }

    public void setCategoryTicket(CategoryTicketEntity categoryTicket) {
        this.categoryTicket = categoryTicket;
    }
    
    
}
