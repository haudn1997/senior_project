
package com.mycompany.jv24_spring_project_final.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "combo")
public class ComboEntity implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String name;
    
    private String description;
    
    private double price;
    
    @OneToMany(mappedBy = "combo", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ComboDetailEntity> comboDetail;

    public ComboEntity() {
    }

    public ComboEntity(int id) {
        this.id = id;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<ComboDetailEntity> getComboDetail() {
        return comboDetail;
    }

    public void setComboDetail(List<ComboDetailEntity> comboDetail) {
        this.comboDetail = comboDetail;
    }
    
    
}
