import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CampsiteComponent } from './components/campsite/campsite.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { WhoComponent } from './components/who/who.component';
import { WhyComponent } from './components/why/why.component';
import { PersonComponent } from './components/person/person.component';


const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: CampsiteComponent },
  { path: 'campsite/userCampsites', component: CampsiteComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'person', component: PersonComponent },
  { path: 'person/:id', component: PersonComponent },
  { path: 'who', component: WhoComponent },
  { path: 'why', component: WhyComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
