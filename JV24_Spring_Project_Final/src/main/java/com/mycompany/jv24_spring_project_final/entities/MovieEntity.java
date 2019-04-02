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
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "movie")
public class MovieEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private String description;

    private String actor;

    private String director;

    private String image;
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "date_start_showing")
    private Date dateStartShowing;

    private String link;

    @Temporal(TemporalType.TIME)
    @DateTimeFormat(pattern = "HH:mm:ss")
    @Column(name = "time")
    private Date time;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "country_id")
    private CountryEntity country;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_movie_id")
    private CategoryMovieEntity categoryMovie;

    @OneToMany(mappedBy = "movie", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<BookTicketEntity> bookTicket;

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<MovieScheduleEntity> movieSchedule;

    public MovieEntity() {
    }

    public MovieEntity(int id) {
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getDateStartShowing() {
        return dateStartShowing;
    }

    public void setDateStartShowing(Date dateStartShowing) {
        this.dateStartShowing = dateStartShowing;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public CountryEntity getCountry() {
        return country;
    }

    public void setCountry(CountryEntity country) {
        this.country = country;
    }

    public CategoryMovieEntity getCategoryMovie() {
        return categoryMovie;
    }

    public void setCategoryMovie(CategoryMovieEntity categoryMovie) {
        this.categoryMovie = categoryMovie;
    }

    public List<BookTicketEntity> getBookTicket() {
        return bookTicket;
    }

    public void setBookTicket(List<BookTicketEntity> bookTicket) {
        this.bookTicket = bookTicket;
    }

    public List<MovieScheduleEntity> getMovieSchedule() {
        return movieSchedule;
    }

    public void setMovieSchedule(List<MovieScheduleEntity> movieSchedule) {
        this.movieSchedule = movieSchedule;
    }

}
