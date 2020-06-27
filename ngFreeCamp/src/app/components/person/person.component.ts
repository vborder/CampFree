import { Component, OnInit } from '@angular/core';
import { Person } from 'src/app/models/person';
import { PersonService } from 'src/app/services/person.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-person',
  templateUrl: './person.component.html',
  styleUrls: ['./person.component.css']
})
export class PersonComponent implements OnInit {


  selected = null;
  newPerson = new Person();
  editPerson = null;




  person: Person[] = [];

  constructor(
    private http: HttpClient,
    private personService: PersonService
  ) { }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    console.log('reloading');

    this.personService.index().subscribe(
      data => {
        this.person = data;
        this.selected = null;
        this.editPerson = null;
      },
      fail => {
        console.error('TodoListComponent.index(): error retrieving todos');
        console.error(fail);
      }
    );
  }


  // GET person by ID



}
