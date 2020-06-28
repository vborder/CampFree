import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Campsite } from '../models/campsite';
import { Person } from '../models/person';
import { Router } from '@angular/router';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class PersonService {
  private url = environment.baseUrl + 'api/person';
  private baseUrl = environment.baseUrl;

  persons: Person[] = [];
  user: User;

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
    private router: Router
  ) { }



  // search person by id

  show(id){
    return this.http.get<Person>(this.url + '/' + id). pipe(
      catchError((err: any) => {
        console.log('person service show is not working');
        return throwError('person service show is not working properly');
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

  findPersonByUsername(username: string) {
    return this.http.get<User>(this.url + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error finding person by username');
      })
    );
  }

  getCampsitesByUsername() {
    return this.http.get<Campsite[]>(this.baseUrl + 'api/campsite/username').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error finding campsites by username');
      })
    );
  }


}
