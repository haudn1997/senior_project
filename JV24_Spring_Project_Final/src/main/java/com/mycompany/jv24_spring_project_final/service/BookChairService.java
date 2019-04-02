
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.BookChairEntity;
import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.repository.BookChairRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookChairService {
    @Autowired
    private BookChairRepository bookChairRepository;
    
    public BookChairEntity save(BookChairEntity b) {
        return bookChairRepository.save(b);
    }
    
    public List<BookChairEntity> findByBookTicket(BookTicketEntity b) {
        return bookChairRepository.findByBookTicket(b);
    }
}
