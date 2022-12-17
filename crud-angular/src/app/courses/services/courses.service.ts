import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { delay, first, tap } from 'rxjs';
import { Course } from '../model/course';

@Injectable({
  providedIn: 'root'
})
export class CoursesService {

  //endpoint url
  private readonly API = 'api/courses';

  constructor(private httpClient: HttpClient) {}

  // Retorna um Observable de array de cursos --> Observable<Course[]>
  list(){
    return this.httpClient.get<Course[]>(this.API)
    .pipe(
      first(),
      delay(500)
      // tap(courses => console.log(courses))
    );
  }
}
