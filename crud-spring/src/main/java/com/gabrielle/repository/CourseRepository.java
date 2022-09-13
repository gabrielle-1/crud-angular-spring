package com.gabrielle.repository;

import com.gabrielle.model.Course;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // Diz ao spring que é uma conexão
public interface CourseRepository extends JpaRepository<Course, Long> {

}
