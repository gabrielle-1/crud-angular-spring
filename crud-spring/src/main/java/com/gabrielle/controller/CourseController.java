package com.gabrielle.controller;

import java.util.List;
import java.util.Optional;

import com.gabrielle.model.Course;
import com.gabrielle.repository.CourseRepository;

import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

// Ao anotar a classe como Controller, temos o Bean que é uma instância dessa classe/componente chamado Component

// @Component --> O Spring cria a instancia(Bean) 

// Diz para o spring que essa classe possui um endpoint/URL para ser acessado
// pela API

@RestController // Componente onde expõe uma API ou endpoint
@RequestMapping("/api/courses")
// @AllArgsConstructor -->Cria o construtor automaticamente(equivalente ao
// Autowired)

public class CourseController {

    private final CourseRepository courseRepository;

    public CourseController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping
    public List<Course> list() {
        return courseRepository.findAll();
    }

    @PostMapping
    @ResponseStatus(code = HttpStatus.CREATED)
    public ResponseEntity<Course> create(@RequestBody Course course) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(courseRepository.save(course));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable("id") Long id) {
        var optionalCourse = this.courseRepository.findById(id);
        if (optionalCourse.isPresent()) {
            courseRepository.deleteById(id);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).<Void>build();
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Course> update(@PathVariable Long id, @RequestBody Course course) {

        var optionalCourse = this.courseRepository.findById(id);
        if (optionalCourse.isPresent()) {
            BeanUtils.copyProperties(course, optionalCourse);
            return ResponseEntity.status(HttpStatus.OK).body(courseRepository.save(course));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Course> findById(@PathVariable Long id) {
        return this.courseRepository.findById(id)
                .map(record -> ResponseEntity.ok().body(record))
                .orElse(ResponseEntity.notFound().build());
    }

}
