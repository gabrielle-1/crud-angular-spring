import { Observable } from 'rxjs';
import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Course } from '../model/course';
import { CoursesService } from '../services/courses.service';

@Component({
  selector: 'app-courses-list',
  templateUrl: './courses-list.component.html',
  styleUrls: ['./courses-list.component.scss']
})
export class CoursesListComponent {

  // @Input -> O que será passado para o componente(utilizado quando há relacionamento entre componente filho e componente pai/mãe)
  // @Input() courses: Course[] = [];
  courses$: Observable<Course[]>;

  readonly displayedColumns = ["name", "category", "actions"];

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private coursesService: CoursesService
  ){
    this.courses$ = this.coursesService.list();
  }

  // Redireciona para: courses/new para a criação de um novo curso
  onAdd() {
    this.router.navigate(['new'], {relativeTo: this.route});
  }
}
