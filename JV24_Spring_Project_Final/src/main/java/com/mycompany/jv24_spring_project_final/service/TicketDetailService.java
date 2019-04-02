
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity;
import com.mycompany.jv24_spring_project_final.repository.TicketDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketDetailService {
    @Autowired
    private TicketDetailRepository ticketDetailRepository;
    
    public TicketDetailEntity save(TicketDetailEntity t) {
        return ticketDetailRepository.save(t);
    }
}
