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
import { Picture } from '../models/picture';

@Injectable({
  providedIn: 'root'
})
export class PersonService {
  private url = environment.baseUrl + 'api/person';
  private baseUrl = environment.baseUrl;
  private url2 = environment.baseUrl + 'api/campsite';
  private url3 = environment.baseUrl + 'api/pictures';

  persons: Person[] = [];
  user: User;

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private datePipe: DatePipe,
    private router: Router
  ) { }


index() {
  return this.http.get<Person[]>(this.url + '')
  .pipe(
    catchError((err: any) => {
      console.log('person service is not reached');
      return throwError('person service index is not working');
    })

  );

}

indexFeature(){
  return this.http.get<Person[]>(this.url + '/feature')
  .pipe(
    catchError((err: any) => {
      console.log('person service is not reached');
      return throwError('person service index is not working');
    })

  );

}

  // search person by id

  show(personId: number){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Person>(this.url + `/${personId}`, httpOptions). pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('PersonService.show(): Error retrieving person: ' + err);
      })
    );
  }

display() {
  const credentials = this.auth.getCredentials();
  const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
  return this.http.get<Person>(this.url + '/username', httpOptions). pipe(
    catchError((err: any) => {
      console.error(err);
      return throwError('UserService.show(): Error retrieving user: ' + err);
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
    const credentials = this.auth.getCredentials();
    const httpOptions = {
        headers: new HttpHeaders({
          Authorization: `Basic ${credentials}`,
          'X-Requested-With': 'XMLHttpRequest'
        })
      };
    return this.http.put(this.url + '/' + person.id, person, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error updating person profile');
      })
    );
  }

  delete(id: number) {
    const credentials = this.auth.getCredentials();
    const httpOptions = {
        headers: new HttpHeaders({
          Authorization: `Basic ${credentials}`,
          'X-Requested-With': 'XMLHttpRequest'
        })
      };
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

  getPicturesByUserId() {
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };

    return this.http.get<Picture[]>(this.url + '/userPictures', httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Error finding pictures by username');
      })
    );
  }

}
