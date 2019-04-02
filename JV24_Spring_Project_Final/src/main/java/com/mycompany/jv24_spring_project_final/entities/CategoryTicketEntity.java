
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
@Table(name = "category_ticket")
public class CategoryTicketEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String name;
    
    private double price;
    
    @OneToMany(mappedBy = "categoryTicket", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<TicketDetailEntity> ticketDetail;

    public CategoryTicketEntity() {
    }

    public CategoryTicketEntity(int id) {
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<TicketDetailEntity> getTicketDetail() {
        return ticketDetail;
    }

    public void setTicketDetail(List<TicketDetailEntity> ticketDetail) {
        this.ticketDetail = ticketDetail;
    }
    
    
}
