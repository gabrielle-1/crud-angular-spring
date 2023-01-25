package com.gabrielle.repository;

import com.gabrielle.model.Course;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // Diz ao spring que é uma conexão
public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByStatus(String status);
}
