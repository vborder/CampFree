import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { Person } from 'src/app/models/person';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  // newUser = new User();

  constructor() { }

  ngOnInit(): void {
  }

  register(form: NgForm) {
    console.log(form);
    const user: User = new User();
    const person: Person = new Person();

    user.username = form.value.username;
    user.password = form.value.password;
    console.log(user);

    person.email = form.value.email;
    console.log(form.value.email);
    person.firstName = form.value.firstName;
    person.lastName = form.value.lastName;
    person.state = form.value.state;
    person.bio = form.value.bio;

    person.user = user;

    console.log(person);

  }

  //   createNewPerson(form: NgForm) {
  //   console.log(form);
  //   const person: Person = form.value;
  //   console.log(person);
  // }



}
