import { Location } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { NonNullableFormBuilder } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';

import { CoursesService } from '../../services/courses.service';
import { ActivatedRoute } from '@angular/router';
import { Course } from '../../model/course';

@Component({
  selector: 'app-course-form',
  templateUrl: './course-form.component.html',
  styleUrls: ['./course-form.component.scss']
})
export class CourseFormComponent implements OnInit {

  form = this.formBuilder.group({
    _id: [''],
    name: [''],
    category: ['']
  });

  constructor(private formBuilder: NonNullableFormBuilder,
    private service: CoursesService,
    private snackBar: MatSnackBar,
    private location: Location,
    private route: ActivatedRoute) {
  }

  ngOnInit(): void {
    const course: Course = this.route.snapshot.data['course'];
    this.form.setValue({
      name: course.name,
      category: course.category,
      _id: course._id
    });
  }

  onCancel() {
    this.location.back();
  }

  onSubmit() {
    const values = this.form.value;
    this.service.save(values)
    .subscribe(result => this.onSuccess(),
    error => this.onError());
  }

  private onError() {
    this.snackBar.open('Erro ao salvar curso.', '', {duration:5000})
  }

  private onSuccess() {
    this.snackBar.open('Curso salvo com sucesso!', '', {duration:5000})
    this.onCancel();
  }

}
