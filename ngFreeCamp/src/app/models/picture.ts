import { Campsite } from './campsite';
import { Person } from './person';

export class Picture {
  id: number;
  imageUrl: string;
  campsite: Campsite;
  person: Person;

  constructor(id?: number, imageUrl?: string, campsite?: Campsite, person?: Person) {
    this.id = id;
    this.imageUrl = imageUrl;

  }
}
