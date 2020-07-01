import { Pipe, PipeTransform } from '@angular/core';
import { Campsite } from '../models/campsite';


@Pipe({
  name: 'enabled'
})
export class EnabledPipe implements PipeTransform {

  transform(campsites: Campsite[])  {
    let result = [];
    for (let index = 0; index < campsites.length; index++) {
      if(campsites[index].enabled ) {
        result.push(campsites[index]);
      }

    }



    return result;
  }



}
