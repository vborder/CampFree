import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Campsite } from '../models/campsite';
import { DatePipe } from '@angular/common';
import { AuthService } from './auth.service';
import { Feature } from '../models/feature';


@Injectable({
  providedIn: 'root'
})
export class CampsiteService {
  private url = environment.baseUrl + 'api/campsite';
  private baseUrl = environment.baseUrl;


  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
    private auth: AuthService
  ) { }


  // show all campsites
  index(){
    return this.http.get<Campsite[]>(this.url + '')
    .pipe(
      catchError((err: any) => {
        console.log('campsite service is not reached');
        return throwError('campsite service index is not working');
      })

    );

  }
// find all features
  indexFeature(){
    return this.http.get<Feature[]>(this.url + '/feature')
    .pipe(
      catchError((err: any) => {
        console.log('campsite service is not reached');
        return throwError('campsite service index is not working');
      })

    );

  }

  // create campsite
  create(campsite: Campsite){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
      console.log(campsite);
    return this.http.post<Campsite>(this.url, campsite, httpOptions).pipe (
      catchError((err: any) => {
        console.log('campsite service create is not working');
        return throwError('campsite service create is not working properly');
      })
    );
  }

  // update campsite
  update(campsite: Campsite){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
    return this.http.put<Campsite>(this.url + '/' + campsite.id, campsite, httpOptions).pipe (
      catchError((err: any) => {
        console.log('Campsite service update is not working');
        return throwError('Campsite service update is not working properly');

      })
    );

  }


  // delete campsite (disable)
  delete(id: number){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
    return this.http.delete<Campsite>(this.url + '/' + id, httpOptions). pipe(
      catchError((err: any) => {
        console.log('Campsite service delete is not working');
        return throwError('Campsite service delete is not working properly');
      })
    );

  }

  // show campsite by id
  show(id){
    const credentials = this.auth.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
    return this.http.get<Campsite>(this.url + '/' + id, httpOptions). pipe(
      catchError((err: any) => {
        console.log('Campsite service show is not working');
        return throwError('Campsite service show is not working properly');
      })
    );

  }




  }



