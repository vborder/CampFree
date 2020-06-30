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
import { Picture } from 'src/app/models/picture';
import { PictureService } from 'src/app/services/picture.service';

@Component({
  selector: 'app-person',
  templateUrl: './person.component.html',
  styleUrls: ['./person.component.css'],
})
export class PersonComponent implements OnInit {
  showCamps = false;
  personSelected: Person = null;
  newPerson = new Person();
  editPerson = null;
  newCampsite: Campsite = new Campsite();
  personCampsites: Campsite[] = [];
  persons: Person[] = [];
  campPics: Picture[] = [];
  showUserCamps = false;
  selected = null;
  editCampsite = null;
  showAComs = false;
  showEComs = false;
  showDComs = false;
  showCComs = false;
  showCCamp = false;
  showECamp = false;

  toggleCamps() {
    this.showCamps = !this.showCamps;
    this.selected = null;
  }

  constructor(
    private http: HttpClient,
    private personService: PersonService,
    private campsiteService: CampsiteService,
    private pictureService: PictureService,
    private route: ActivatedRoute,
    private auth: AuthService,
    private router: Router
  ) {}

  toggleUserCamps() {
    this.showUserCamps = !this.showUserCamps;
    this.selected = null;
  }

  onSubmit(campsite){
    this.selected = campsite;
  }

  ngOnInit(): void {
    if (!this.auth.checkLogin) {
      this.router.navigateByUrl('/login');
    }

    if (!this.personSelected) {
      // const personIdParam = this.route.snapshot.paramMap.get('id');
      // const personId = parseInt(personIdParam, 10);
      this.personService.display().subscribe(
        (person) => {
          console.log(person);
          this.personSelected = person;
          this.getCampsitesByUserId();
          this.getPicturesByUserId();

        },
        (fail) => {
              console.error();
              console.error(fail);
              this.router.navigateByUrl('not found');
            }
      );
      // this.personService.show(personId).subscribe(
      //   (person) => {
      //     this.personSelected = person;
      //     // this.personSelected.id;
      //   },
      //   (fail) => {
      //     console.error();
      //     console.error(fail);
      //     this.router.navigateByUrl('not found');
      //   }
      // );
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

  getPicturesByUserId() {
    this.personService.getPicturesByUserId().subscribe(
      (data) => {
        this.campPics = data;
        console.log(this.campPics);

      },
      (fail) => {
        console.error();
        console.error(fail);
      }
    );
  }

  toggleECamp(campsiteEdit){
    this.showECamp = !this.showECamp;
    this.editCampsite = campsiteEdit;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCamps = null;
    this.showCCamp = null;
  }

  toggleEComs(){
    this.showEComs = !this.showEComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  // update campsite information
  updatePassRes(campsite: Campsite){
    console.log(campsite);

    this.selected = campsite;
    this.editCampsite = Object.assign({}, this.selected);
    this.updateCampsite(campsite);
  }

  // update campsite
  updateCampsite(campsite){
    this.campsiteService.update(campsite).subscribe(
      reserve => {console.log('reservation update success');
                  this.reload();
                  this.selected = null;
      },
      fail => {
        console.error('Campsite component error');
      }
    );
  }

  // delete campsite
  deleteCampsite(id: number) {
    this.campsiteService.delete(id).subscribe(
      reservation => {
        console.log('reservation delete was successful');
        this.reload();
      },
      fail => {
        console.error('TodoListComponent.index(): error retrieving todos');
        console.error(fail);
      }
    );
  }


  displayAll() {
    this.selected = null;

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
}
