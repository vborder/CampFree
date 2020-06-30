import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from './auth.service';
import { DatePipe } from '@angular/common';
import { Router } from '@angular/router';
import { environment } from 'src/environments/environment';
import { Picture } from '../models/picture';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class PictureService {
  private url = environment.baseUrl + 'api/person';
  private baseUrl = environment.baseUrl;
  private url2 = environment.baseUrl + 'api/campsite';

  pictures: Picture[] = [];
  user: User;

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private datePipe: DatePipe,
    private router: Router
  ) { }
}

// getPicturesByUserId() {
//   const credentials = this.auth.getCredentials();
//   const httpOptions = {
//     headers: new HttpHeaders({
//       Authorization: `Basic ${credentials}`,
//       'X-Requested-With': 'XMLHttpRequest'
//     })
//   };

//   return this.http.get<Picture[]>(this.url2 + '/userCampsites', httpOptions).pipe(
//     catchError((err: any) => {
//       console.log(err);
//       return throwError('Error finding pictures by username');
//     })
//   );
// }
