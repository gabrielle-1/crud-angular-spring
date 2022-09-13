package com.gabrielle.controller;

import java.util.List;
import java.util.Optional;

import com.gabrielle.model.Course;
import com.gabrielle.repository.CourseRepository;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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

    // Poderiamos fazer a injeção das dependencias via Autowired -->
    // @Autowired
    // private final CourseRepository
    // Ou via Constrtutor(mais indicado)

    public CourseController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping
    // GetMapping é o mesmo que: @RequestMapping(method = ResquestMethod.GET)
    public List<Course> list() {
        return courseRepository.findAll();
    }

    // @RequestMapping(method= RequestMethod.POST)
    @PostMapping
    @ResponseStatus(code = HttpStatus.CREATED)
    public Course create(@RequestBody Course course) {
        return this.courseRepository.save(course);
        // return ResponseEntity.status(HttpStatus.CREATED)
        // .body(courseRepository.save(course));
    }

    @DeleteMapping("/delete/{id}")
    // GetMapping é o mesmo que: @RequestMapping(method = ResquestMethod.GET)
    public void teste(@PathVariable("id") Long id) {
        this.courseRepository.deleteById(id);
    }

    @PostMapping("/update")
    public Course update(@RequestBody Course course) {
        var optionalCourse = this.find(course.getId());
        // this.courseRepository.update(optionalCourse, "", "");
        return null;

    }

    public Optional<Course> find(long id) {
        return this.courseRepository.findById(id);
    }

}
