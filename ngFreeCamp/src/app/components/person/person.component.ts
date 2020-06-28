import { Component, OnInit } from '@angular/core';
import { Person } from 'src/app/models/person';
import { PersonService } from 'src/app/services/person.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Campsite } from 'src/app/models/campsite';
import { CampsiteService } from 'src/app/services/campsite.service';

@Component({
  selector: 'app-person',
  templateUrl: './person.component.html',
  styleUrls: ['./person.component.css']
})
export class PersonComponent implements OnInit {

  selected = null;
  newPerson = new Person();
  editPerson = null;
  newCampsite: Campsite = new Campsite();




  person: Person[] = [];

  constructor(
    private http: HttpClient,
    private personService: PersonService,
    private campsiteService: CampsiteService
  ) { }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    console.log('reloading');



  }

  index(){

  }
  // GET person by ID

  // create campsite?
  createCampsite() {
    this.campsiteService.create(this.newCampsite).subscribe(
      data => {

      },
      err => {
        console.log(err);
      }
    );
  }

  // display profile
  // displayPersonProfile() {
  //   this.selected =
  // }




}
