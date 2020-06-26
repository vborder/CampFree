import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AgmCoreModule } from '@agm/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CampsiteComponent } from './components/campsite/campsite.component';
import { CommentComponent } from './components/comment/comment.component';
import { PersonComponent } from './components/person/person.component';
import { UserComponent } from './components/user/user.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { WhoComponent } from './components/who/who.component';
import { WhyComponent } from './components/why/why.component';
import { DatePipe } from '@angular/common';

@NgModule({
  declarations: [
    AppComponent,
    CampsiteComponent,
    CommentComponent,
    PersonComponent,
    UserComponent,
    NavBarComponent,
    LoginComponent,
    RegisterComponent,
    WhoComponent,
    WhyComponent

  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule,
    NgbModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyBsCj7AmihtNZUsUjwnDrgZS57oy_QSJN4'
    })
  ],
  providers: [
    DatePipe
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
