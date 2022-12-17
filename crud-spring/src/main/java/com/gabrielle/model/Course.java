package com.gabrielle.model;

import java.util.Optional;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
@Entity
// @Table(name = "cursos")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) // Auto increment
    @JsonProperty("_id")
    // @JsonIgnore("_id") ignora o campo
    private long id;

    @Column(name = "nome", length = 200, nullable = false)
    private String name;
    @Column(name = "categoria", length = 12, nullable = false)
    private String category;

    public String getName() {
        return this.name;
    }

    public String getCategory() {
        return this.category;
    }

    public long getId() {
        return this.id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    // public void update(Optional<Course> course, String name, String category){
    // course.get(Course course);
    // course.setCategory(category);
    // course.setName(name);
    // }

}
