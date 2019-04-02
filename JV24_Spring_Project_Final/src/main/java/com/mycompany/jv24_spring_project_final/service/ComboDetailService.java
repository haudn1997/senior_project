
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.ComboDetailEntity;
import com.mycompany.jv24_spring_project_final.repository.ComboDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComboDetailService {
    @Autowired
    private ComboDetailRepository comboDetailRepository;
    
    public ComboDetailEntity save(ComboDetailEntity c) {
        return comboDetailRepository.save(c);
    }
}
