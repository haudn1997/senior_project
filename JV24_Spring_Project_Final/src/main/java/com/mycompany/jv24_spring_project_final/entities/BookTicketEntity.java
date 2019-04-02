package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Pattern;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "book_ticket")
public class BookTicketEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Column(name = "create_at")
    private Date createAt;

    @Column(name = "total_price")
    private double totalPrice;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "movie_schedule_id")
    private MovieScheduleEntity movieScheduleEntity;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "movie_id")
    private MovieEntity movie;

    @OneToMany(mappedBy = "bookTicket", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ComboDetailEntity> comboDetail;

    @OneToMany(mappedBy = "bookTicket", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<TicketDetailEntity> ticketDetail;

    @OneToMany(mappedBy = "bookTicket", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<BookChairEntity> bookChair;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private UserEntity user;

    public BookTicketEntity() {
    }

    public BookTicketEntity(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public MovieScheduleEntity getMovieScheduleEntity() {
        return movieScheduleEntity;
    }

    public void setMovieScheduleEntity(MovieScheduleEntity movieScheduleEntity) {
        this.movieScheduleEntity = movieScheduleEntity;
    }

    public List<BookChairEntity> getBookChair() {
        return bookChair;
    }

    public void setBookChair(List<BookChairEntity> bookChair) {
        this.bookChair = bookChair;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public List<ComboDetailEntity> getComboDetail() {
        return comboDetail;
    }

    public void setComboDetail(List<ComboDetailEntity> comboDetail) {
        this.comboDetail = comboDetail;
    }

    public List<TicketDetailEntity> getTicketDetail() {
        return ticketDetail;
    }

    public void setTicketDetail(List<TicketDetailEntity> ticketDetail) {
        this.ticketDetail = ticketDetail;
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

}
