import { State } from './state';

export class Campsite {
  id: number;
  name: string;
  location: string;
  latitude: number;
  longitude: number;
  state: State;
  features: string;
  pictureUrl: string;



  constructor(id?: number, name?: string, location?: string, latitude?: number,
              longitude?: number, state?: State, features?: string, pictureUrl?: string){
      this.id = id;
		    this.name = name;
		    this.location = location;
		    this.latitude = latitude;
		    this.longitude = longitude;
		    this.state = state;
		    this.features = features;
		    this.pictureUrl = pictureUrl;
  }

}
