import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CampsiteComponent } from './components/campsite/campsite.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { UserComponent } from './components/user/user.component';
import { WhoComponent } from './components/who/who.component';
import { WhyComponent } from './components/why/why.component';


const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: CampsiteComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'user', component: UserComponent },
  { path: 'who', component: WhoComponent },
  { path: 'why', component: WhyComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
