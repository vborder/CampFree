import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { DatePipe } from '@angular/common';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private url = environment.baseUrl + 'api/person';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
  ) { }


  // update user
  update(user){
    return this.http.put<User>(this.url + '/' + user.id, user).pipe (
      catchError((err: any) => {
        console.log('reservation service update is not working');
        return throwError('reservation service update is not working properly');

      })
    );

  }
}
