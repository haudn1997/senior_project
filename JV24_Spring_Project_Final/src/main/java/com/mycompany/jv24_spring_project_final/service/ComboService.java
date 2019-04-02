
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.ComboEntity;
import com.mycompany.jv24_spring_project_final.repository.ComboRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComboService {
    @Autowired
    private ComboRepository comboRepository;
    
    public List<ComboEntity> findAll() {
        return (List<ComboEntity>) comboRepository.findAll();
    }
    
    public ComboEntity findComboId(int id) {
        return comboRepository.findOne(id);
    }
}
