
package com.mycompany.jv24_spring_project_final.repository;

import com.mycompany.jv24_spring_project_final.entities.BookChairEntity;
import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import java.io.Serializable;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookChairRepository extends CrudRepository<BookChairEntity, Integer>{
    List<BookChairEntity> findByBookTicket(BookTicketEntity b);
}
