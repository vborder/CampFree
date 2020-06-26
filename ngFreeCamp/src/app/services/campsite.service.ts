import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Campsite } from '../models/campsite';
import { DatePipe } from '@angular/common';


@Injectable({
  providedIn: 'root'
})
export class CampsiteService {
  private url = environment.baseUrl + 'api/campsite';
  private baseUrl = environment.baseUrl;


  constructor(
    private http: HttpClient,
    private datePipe: DatePipe
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

  // create campsite
  create(reservation: Campsite){
    console.log(reservation);

    return this.http.post<Campsite>(this.url, reservation).pipe (
      catchError((err: any) => {
        console.log('campsite service create is not working');
        return throwError('campsite service create is not working properly');
      })
    );
  }

  // update campsite
  update(campsite: Campsite){
    return this.http.put<Campsite>(this.url + '/' + campsite.id, campsite).pipe (
      catchError((err: any) => {
        console.log('Campsite service update is not working');
        return throwError('Campsite service update is not working properly');

      })
    );

  }


  // delete campsite (disable)
  delete(id){
    return this.http.delete<Campsite>(this.url + '/' + id). pipe(
      catchError((err: any) => {
        console.log('Campsite service delete is not working');
        return throwError('Campsite service delete is not working properly');
      })
    );

  }

  // show campsite by id
  show(id){
    return this.http.get<Campsite>(this.url + '/' + id). pipe(
      catchError((err: any) => {
        console.log('Campsite service show is not working');
        return throwError('Campsite service show is not working properly');
      })
    );

  }




  }



