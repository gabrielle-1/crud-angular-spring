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
    );
  }

  save(course: Partial<Course>){
    if (course._id) {
      return this.update(course);
    }
    return this.create(course);
  }

  loadById(id: string){
    return this.httpClient.get<Course>(`${this.API}/${id}`);
  }

  delete(id: string){
    return this.httpClient.delete(`${this.API}/${id}`).pipe(first());
  }

  private create(course: Partial<Course>){
    return this.httpClient.post<Course>(this.API, course).pipe(first());
  }

  private update(course: Partial<Course>){
    return this.httpClient.put<Course>(`${this.API}/${course._id}`, course).pipe(first());
  }

}
