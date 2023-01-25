package com.gabrielle.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import com.gabrielle.model.Course;
import com.gabrielle.repository.CourseRepository;

@Service
public class CourseService {

    CourseRepository courseRepository;

    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    public List<Course> list() {
        return this.courseRepository.findByStatus("Ativo");
    }

    public Course create(Course course) {
        return this.courseRepository.save(course);
    }

    public boolean delete(Long id) {
        var optionalCourse = this.courseRepository.findById(id);
        if (optionalCourse.isPresent()) {
            boolean isActive = (optionalCourse.get().getStatus().equals("Ativo"));
            if (isActive) {
                optionalCourse.get().setStatus("Inativo");
                courseRepository.save(optionalCourse.get());
                return true;
            }
        }
        return false;
    }

    public Course update(Long id, Course course) {
        var optionalCourse = this.courseRepository.findById(id);
        if (optionalCourse.isPresent()) {
            BeanUtils.copyProperties(course, optionalCourse);
            this.courseRepository.save(course);
            return course;
        }
        return null;
    }

    public Course findById(Long id) {
        var courseFinded = this.courseRepository.findById(id);
        if (courseFinded.isPresent()) {
            return courseFinded.get();
        }
        return null;
    }

}
