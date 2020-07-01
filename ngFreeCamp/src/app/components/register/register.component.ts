import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { User } from 'src/app/models/user';
import { Person } from 'src/app/models/person';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { State } from 'src/app/models/state';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  // newUser = new User();

  constructor(
    private auth: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  register(form: NgForm) {
    const user: User = new User();
    const person: Person = new Person();

    user.username = form.value.username;
    user.password = form.value.password;
    console.log(user);

    person.email = form.value.email;
    console.log(form.value.email);
    person.firstName = form.value.firstName;
    person.lastName = form.value.lastName;
    person.state = new State();
    person.state.name = form.value.state;
    person.bio = form.value.bio;

    person.user = user;

    console.log(person);

    this.auth.register(person).subscribe(
      registeredUser => {
        console.log('RegisterComponent.register(): User registered');
        this.auth.login(user.username, user.password).subscribe(
          loggedIn => {
            console.log('RegisterComponent.register(): User logged in: ');
            console.log(loggedIn);
            this.router.navigateByUrl('/home'); // where is a logged in user navigating to?

          },
          notLoggedIn => {
            console.error('RegisterCompenent.register(): login failed');
            console.error(notLoggedIn);
          }
        );
      },
      fail => {
        console.error('RegisterCompenent.register(): registration failed');
        console.error(fail);
      }
    );

  }

  //   createNewPerson(form: NgForm) {
  //   console.log(form);
  //   const person: Person = form.value;
  //   console.log(person);
  // }



}
