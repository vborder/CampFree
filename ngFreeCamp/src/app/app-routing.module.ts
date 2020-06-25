import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CampsiteComponent } from './components/campsite/campsite.component';


const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: CampsiteComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
