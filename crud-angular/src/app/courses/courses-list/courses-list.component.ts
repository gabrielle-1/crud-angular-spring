import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Course } from '../model/course';

@Component({
  selector: 'app-courses-list',
  templateUrl: './courses-list.component.html',
  styleUrls: ['./courses-list.component.scss']
})
export class CoursesListComponent {

  courses: Course[] = [];
  displayedColumns = ["name", "category", "actions"];

  constructor(
    private router: Router,
    private route: ActivatedRoute
  ){

  }

  // Redireciona para: courses/new para a criação de um novo curso
  onAdd() {
    this.router.navigate(['new'], {relativeTo: this.route});
  }
}
