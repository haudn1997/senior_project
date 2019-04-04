
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.CategoryTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import java.io.Serializable;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface MovieRepository extends JpaRepository<MovieEntity, Integer>{
    
    Page<MovieEntity> findAll(Pageable pageable);
    
    @Query(value = "SELECT * FROM `movie` WHERE date_start_showing <= ?1 ", nativeQuery = true)
    List<MovieEntity> findDate(String date);
    
    @Query(value = "SELECT * FROM `movie` WHERE date_start_showing > ?1 ", nativeQuery = true)
    List<MovieEntity> findDateComing(String date);
    
    Page<MovieEntity> findByNameContaining(String name, Pageable pageable);
    
    Page<MovieEntity> findByCategoryMovie(CategoryTicketEntity categoryId, Pageable pageable);
    
    List<MovieEntity> findByNameLike(String searchText);
}
