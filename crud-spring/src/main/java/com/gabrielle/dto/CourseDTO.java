package com.gabrielle.dto;

import com.gabrielle.model.Course;

public class CourseDTO {

    private String name;
    private String category;

    public CourseDTO(String name, String category) {
        this.name = name;
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Course convert() {
        return new Course(name, category);
    }
}
