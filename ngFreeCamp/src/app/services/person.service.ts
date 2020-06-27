import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Campsite } from '../models/campsite';
import { Person } from '../models/person';

@Injectable({
  providedIn: 'root'
})
export class PersonService {
  private url = environment.baseUrl + 'api/person';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
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
}
