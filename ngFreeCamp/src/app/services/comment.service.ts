import { Injectable } from '@angular/core';
import { catchError} from 'rxjs/operators';
import { throwError } from 'rxjs';
import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Campsite } from '../models/campsite';


@Injectable({
  providedIn: 'root'
})
export class CommentService {
  private url = environment.baseUrl + 'api/campsite/comment';


  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
  ){

  }


   // index
   index() {
    return this.http.get<Comment[]>(this.url + '')
      .pipe(
        catchError((err: any) => {
        console.log('comment service is not reached');
        return throwError('comment service index is not working');
    })

  );

};

  /*  comment delete */
delete(id){
    return this.http.delete<Comment>(this.url + '/' + id). pipe(
      catchError((err: any) => {
        console.log('comment service delete is not working');
        return throwError('comment service delete is not working properly');
      })
    );

  }

/* comment update */

update(comment){
  return this.http.put<Comment>(this.url + '/' + comment.id, comment).pipe (
    catchError((err: any) => {
      console.log('comment service update is not working');
      return throwError('comment service update is not working properly');

    })
  );

}

// create
create(comment: Comment){
  console.log(comment);

  return this.http.post<Comment>(this.url, comment).pipe (
    catchError((err: any) => {
      console.log('reservation service create is not working');
      return throwError('reservation service create is not working properly');
    })
  );
}
}
