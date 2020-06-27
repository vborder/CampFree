import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(
    private auth: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  login(form: NgForm) {
    const user = form.value;
    console.log(user);
    this.auth.login(user.username, user.password).subscribe(
      loggedIn => {
        console.log('LoginComponent.login(): User logged in: ');
        console.log(loggedIn);
        this.router.navigateByUrl('/home'); // where is a logged in user navigating to?

      },
      notLoggedIn => {
        console.error('LoginCompenent.login(): login failed');
        console.error(notLoggedIn);
      }
    );

  }

}
