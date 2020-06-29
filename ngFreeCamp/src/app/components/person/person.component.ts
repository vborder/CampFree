import { Component, OnInit } from '@angular/core';
import { Person } from 'src/app/models/person';
import { PersonService } from 'src/app/services/person.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Campsite } from 'src/app/models/campsite';
import { CampsiteService } from 'src/app/services/campsite.service';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-person',
  templateUrl: './person.component.html',
  styleUrls: ['./person.component.css'],
})
export class PersonComponent implements OnInit {
  // selected = null;
  personSelected: Person = null;
  newPerson = new Person();
  editPerson = null;
  newCampsite: Campsite = new Campsite();
  personCampsites: Campsite[] = [];
  persons: Person[] = [];

  constructor(
    private http: HttpClient,
    private personService: PersonService,
    private campsiteService: CampsiteService,
    private route: ActivatedRoute,
    private auth: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    if (!this.auth.checkLogin) {
      this.router.navigateByUrl('/login');
    }

    if (!this.personSelected && this.route.snapshot.paramMap.get('id')) {
      const personIdParam = this.route.snapshot.paramMap.get('id');
      const personId = parseInt(personIdParam, 10);
      this.personService.show(personId).subscribe(
        (person) => {
          this.personSelected = person;
          this.getCampsitesByUserId();
        },
        (fail) => {
          console.error();
          console.error(fail);
          this.router.navigateByUrl('not found');
        }
      );
    } else {
      this.reload();
    }
  }

  reload() {
    // this.personService.index().subscribe(
    //     data => {
    //     this.persons = data;
    //   },
    //   fail => {
    //     console.error();
    //     console.error(fail);
    //   }
    // );
    // console.log('reloading');
    // console.log(this.persons);
  }

  getCampsitesByUserId() {
    this.personService.getCampsitesByUserId().subscribe(
      (data) => {
        this.personCampsites = data;
        console.log(this.personCampsites);

      },
      (fail) => {
        console.error();
        console.error(fail);
      }
    );
  }

  // GET person by ID

  // create campsite?
  // createCampsite() {
  //   this.campsiteService.create(this.newCampsite).subscribe(
  //     data => {

  //     },
  //     err => {
  //       console.log(err);
  //     }
  //   );
  // }
}
