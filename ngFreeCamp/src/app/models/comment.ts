import { Campsite } from './campsite';
import { Person } from './person';
import { CampsiteService } from '../services/campsite.service';

export class Comment {
  id: number;
  createdDateTime: number;
  remark: string;
  campsite: Campsite;
  person: Person;
  enabled: boolean;
  campsiteRating: number;


  constructor(
    id?: number,
    createdDateTime?: number,
    remark?: string,
    campsite?: Campsite,
    person?: Person,
    enabled?: boolean,
    campsiteRating?: number
  ){
    this.id= id;
    this.createdDateTime = createdDateTime;
    this.remark = remark;
    this.campsite = campsite;
    this.person = person;
    this.enabled = enabled;
    this.campsiteRating = campsiteRating;
  };
}
