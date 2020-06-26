import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AgmCoreModule } from '@agm/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CampsiteComponent } from './components/campsite/campsite.component';
import { CommentComponent } from './components/comment/comment.component';
import { FeatureComponent } from './components/feature/feature.component';
import { PersonComponent } from './components/person/person.component';
import { PictureComponent } from './components/picture/picture.component';
import { StateComponent } from './components/state/state.component';
import { UserComponent } from './components/user/user.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';

@NgModule({
  declarations: [
    AppComponent,
    CampsiteComponent,
    CommentComponent,
    FeatureComponent,
    PersonComponent,
    PictureComponent,
    StateComponent,
    UserComponent,
    NavBarComponent

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
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
