import { User } from './user';
import { State } from './state';
import { EmailValidator } from '@angular/forms';
import { stringify } from 'querystring';

export class Person {
  id: number;
  email: string;
  firstName: string;
  lastName: string;
  profileImage: string;
  user: User;
  state: State;
  bio: string;


  constructor(
    id?: number,
    email?: string,
    firstName?: string,
    lastName?: string,
    profileImage?: string,
    user?: User,
    state?: State,
    bio?: string
  ){
    this.id = id;
    this.email = email;
    this.firstName = firstName;
    this.lastName = lastName;
    this.profileImage =  profileImage;
    this.user = user;
    this.state = state;
    this.bio = bio;

  }
}
