
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.CategoryMovieEntity;
import com.mycompany.jv24_spring_project_final.entities.CategoryTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.CountryEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.repository.CategoryMovieRepository;
import com.mycompany.jv24_spring_project_final.repository.CountryRepository;
import com.mycompany.jv24_spring_project_final.repository.MovieRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
public class MovieService {
    @Autowired
    private MovieRepository movieRepository;
    
    @Autowired
    private CategoryMovieRepository categoryMovieRepository;
    
    @Autowired
    private CountryRepository countryRepository;
    
    public List<MovieEntity> findAll() {
        return movieRepository.findAll();
    }
    
    public List<MovieEntity> getMovie(){
        return (List<MovieEntity>) movieRepository.findAll();
    }
    
    public List<CountryEntity> getCountry(){
        return (List<CountryEntity>) countryRepository.findAll();
    }
    
    public List<CategoryMovieEntity> getCategoryMovie(){
        return  (List<CategoryMovieEntity>) categoryMovieRepository.findAll();
    }
    
    public MovieEntity saveMovie(MovieEntity movies){
        return movieRepository.save(movies);
    }
    
    public MovieEntity findByIdMovie(int movieId){
        return  movieRepository.findOne(movieId);
    }
    
    public Page<MovieEntity> searchNameMovie(String name, PageRequest pageable) {
        return movieRepository.findByNameContaining(name, pageable);
    }
    
    public boolean checkExistMovie(int id){
        return movieRepository.exists(id);
    }
    
    public boolean deleteMovie(int id){
        movieRepository.delete(id);
        return this.checkExistMovie(id);
    }
    
    public Page<MovieEntity> findAll(PageRequest pageable) {
        return (Page<MovieEntity>) movieRepository.findAll(pageable);
    }
    
    public Page<MovieEntity> findByName(String name, PageRequest pageable) {
        return movieRepository.findByNameContaining(name, pageable);
    }
    
    public MovieEntity findById(int id) {
        MovieEntity m = movieRepository.findOne(id);
        if (m!=null && m.getId()>0) {
            return m;
        } else {
            return new MovieEntity();
        }
    }
    
    public List<MovieEntity> findDate(String date) {
        return movieRepository.findDate(date);
    }
    
    public List<MovieEntity> findDateComing(String date) {
        return movieRepository.findDateComing(date);
    }
}
