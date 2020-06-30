import { Campsite } from './campsite';
import { Person } from './person';

export class Picture {
  id: number;
  imageURL: string;
  campsite: Campsite;
  person: Person;

  constructor(id?: number, imageURL?: string, campsite?: Campsite, person?: Person) {
    this.id = id;
    this.imageURL = imageURL;

  }
}
