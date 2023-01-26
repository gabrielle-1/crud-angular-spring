package com.gabrielle.controller;

import java.util.List;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;

import com.dto.CourseDTO;
import com.gabrielle.model.Course;
import com.gabrielle.service.CourseService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/api/courses")
public class CourseController {

    CourseService courseService;

    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping
    public List<Course> list() {
        return courseService.list();
    }

    @PostMapping
    @ResponseStatus(code = HttpStatus.CREATED)
    public ResponseEntity<Course> create(@RequestBody @Valid CourseDTO dto) {
        var courseSaved = this.courseService.create(dto.convert());
        if (courseSaved != null) {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(courseSaved);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable @NotNull @Positive Long id) {
        var courseDeleted = this.courseService.delete(id);

        if (courseDeleted)
            return ResponseEntity.status(HttpStatus.NO_CONTENT).<Void>build();

        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Course> update(@PathVariable @NotNull @Positive Long id, @RequestBody @Valid CourseDTO dto) {

        var courseUpdated = this.courseService.update(id, dto.convert());
        if (courseUpdated != null) {
            return ResponseEntity.status(HttpStatus.OK).body(courseUpdated);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Course> findById(@PathVariable @NotNull @Positive Long id) {
        var courseFinded = this.courseService.findById(id);

        if (courseFinded != null)
            return ResponseEntity.ok().body(courseFinded);

        return ResponseEntity.notFound().build();
    }

}
