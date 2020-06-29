import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Campsite } from '../models/campsite';
import { Person } from '../models/person';
import { Router } from '@angular/router';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class PersonService {
  private url = environment.baseUrl + 'api/person';
  private baseUrl = environment.baseUrl;
  private url2 = environment.baseUrl + 'api/campsite';

  persons: Person[] = [];
  user: User;

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private datePipe: DatePipe,
    private router: Router
  ) { }



  // search person by id

  show(personId: number){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Person>(`${this.url}/${personId}`, httpOptions). pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('PersonService.show(): Error retrieving person: ' + err);
      })
    );

  }

  // create a new person
  create(person: Person){
    console.log(person);

    return this.http.post<Person>(this.url, person).pipe (
      catchError((err: any) => {
        console.log('person service create is not working');
        return throwError('person service create is not working properly');
      })
    );
  }

  update(person: Person) {
    return this.http.put(this.url + '/' + person.id, person).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating person profile');
      })
    );
  }

  delete(id: number) {
    return this.http.delete(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error deleting person profile');
      })
    );
  }


  getCampsitesByUserId() {
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Campsite[]>(this.url2 + '/userCampsites', httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error finding campsites by username');
      })
    );
  }


}
