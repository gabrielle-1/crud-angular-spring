import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Course } from '../../model/course';

@Component({
  selector: 'app-courses-list',
  templateUrl: './courses-list.component.html',
  styleUrls: ['./courses-list.component.scss']
})

export class CoursesListComponent implements OnInit{

  // @Input -> O que será passado para o componente(utilizado quando há relacionamento entre componente filho e componente pai/mãe)
  @Input() courses: Course[] = [];
  @Output() add = new EventEmitter(false);
  @Output() edit = new EventEmitter(false);
  @Output() delete = new EventEmitter(false);

  readonly displayedColumns = ["name", "category", "actions"];

  constructor(){}

  ngOnInit(): void {}

  // Redireciona para: courses/new para a criação de um novo curso
  onAdd() {
    this.add.emit(true);
  }

  onEdit(course : Course){
    this.edit.emit(course);
  }

  onDelete(course : Course){
    this.delete.emit(course);
  }
}
