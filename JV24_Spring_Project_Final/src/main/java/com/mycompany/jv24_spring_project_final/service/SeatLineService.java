
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.SeatLineEntity;
import com.mycompany.jv24_spring_project_final.repository.SeatLineRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeatLineService {
    @Autowired
    private SeatLineRepository seatLineRepository;
    
    public List<SeatLineEntity> findByRoom(RoomEntity room) {
        return seatLineRepository.findByRoom(room);
    }
}
