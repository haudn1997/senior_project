
package com.mycompany.jv24_spring_project_final.service;

import com.mycompany.jv24_spring_project_final.entities.PositionSeatEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.SeatLineEntity;
import com.mycompany.jv24_spring_project_final.repository.PositionSeatRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PositionSeatService {
    @Autowired
    private PositionSeatRepository positionSeatRepository;
    
    public List<PositionSeatEntity> findBySeatLine(SeatLineEntity s) {
        return positionSeatRepository.findBySeatLine(s);
    }
    
    public PositionSeatEntity findById(int id) {
        PositionSeatEntity p = positionSeatRepository.findOne(id);
        if (p!=null && p.getId()>0) {
            return p;
        } else {
            return new PositionSeatEntity();
        }
    }
}
