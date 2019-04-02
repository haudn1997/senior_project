
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.CategoryTicketEntity;
import com.mycompany.jv24_spring_project_final.repository.CategoryTicketRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryTicketService {
    @Autowired
    private CategoryTicketRepository categoryTicketRepository;
    
    public List<CategoryTicketEntity> findAll() {
        return (List<CategoryTicketEntity>) categoryTicketRepository.findAll();
    }
    
    public CategoryTicketEntity findTicketCategoryById(int id) {
        return categoryTicketRepository.findOne(id);
    }
}
