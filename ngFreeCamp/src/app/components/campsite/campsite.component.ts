// import { Component, OnInit } from '@angular/core';
import {  Component, OnInit, AfterViewInit, ViewChild, ElementRef } from
  '@angular/core';
import { Campsite } from 'src/app/models/campsite';
import { CampsiteService } from 'src/app/services/campsite.service';

@Component({
  selector: 'app-campsite, ngbd-carousel-basic',
  templateUrl: './campsite.component.html',
  styleUrls: ['./campsite.component.css']
})
export class CampsiteComponent implements OnInit, AfterViewInit {


  constructor(
    private campsiteService: CampsiteService

  ) { }
  select = null;
  selected = null;
  editCampsite = null;
  newCampsite = new Campsite();
  campsites: Campsite [] = [];
  showCamps = false;
  showAComs = false;
  showEComs = false;
  showDComs = false;
  showCComs = false;
  showCCamp = false;
  showECamp = false;
  remarks = [];
  editComment = null;
  newComment = null;
  infoWindowOpened = null;
  InforObj = [];



  images = [
    'https://images.pexels.com/photos/3232542/pexels-photo-3232542.jpeg?auto=compress&cs=tinysrgb&dpr=1',
    'https://images.pexels.com/photos/1118785/pexels-photo-1118785.jpeg?auto=compress&cs=tinysrgb&dpr=1',
    'https://images.pexels.com/photos/618848/pexels-photo-618848.jpeg?auto=compress&cs=tinysrgb&dpr=1'

  ];



  title = 'angular-gmap';
  @ViewChild('mapContainer', { static: false }) gmap: ElementRef;
  map: google.maps.Map;
  lat = 39.7392;
  lng = -104.9903;

  markers: google.maps.Marker[] = [];



  mapOptions: google.maps.MapOptions = {
   center: new google.maps.LatLng(this.lat, this.lng),
   zoom: 3
  };


  mapInitializer() {
    this.campsiteService.index().subscribe(
      data => {
        this.campsites = data;

        this.selected = null;
      },
      fail => {
        console.error('CampsiteComponent.index(): error retrieving campsites');
        console.error(fail);
      }
    );
    this.map = new google.maps.Map(this.gmap.nativeElement,
    this.mapOptions);
    console.log(this.campsites);

    this.campsites.forEach((val) => {

      const contentString = val.name + ' \n' + val.latitude + ':' + val.longitude  + ' \n' + val.state.name + '  ' + "<img src='" + val.pictureUrl + "' width='100' height='100' font-weight='800'  />";
      const coordinates = new google.maps.LatLng(val.latitude, val.longitude);
      const infowindow = new google.maps.InfoWindow({
        content: contentString
      });


      const marker = new google.maps.Marker({
        position: coordinates,
        map: this.map
        // title: val.name
      });




      marker.addListener('click', () => {
        this.closeOtherInfo();
        infowindow.open(this.map, marker);
        // infowindow.close();
        this.InforObj[0] = infowindow;
      });

      marker.setMap(this.map);



    });

  }

  closeOtherInfo() {
    if (this.InforObj.length > 0) {
        /* detach the info-window from the marker ... undocumented in the API docs */
        this.InforObj[0].set("marker", null);
        /* and close it */
        this.InforObj[0].close();
        /* blank the array */
        this.InforObj.length = 0;
    }
}

  ngAfterViewInit() {
    this.mapInitializer();

  }



  toggleCCamp(){
    this.showCCamp = !this.showCCamp;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCamps = null;
    this.showECamp = null;
  }

  toggleECamp(campsiteEdit){
    this.showECamp = !this.showECamp;
    this.editCampsite = campsiteEdit;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCamps = null;
    this.showCCamp = null;
  }


  toggleCamps(){
    this.showCamps = !this.showCamps;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleAComs(){
    this.showAComs = !this.showAComs;
    this.selected = null;
    this.showCamps = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleEComs(){
    this.showEComs = !this.showEComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleDComs(){
    this.showDComs = !this.showDComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleCComs(){
    this.showCComs = !this.showDComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  ngOnInit(): void {
      this.reload();
  }

  reload(){
    console.log('reloading');

    this.campsiteService.index().subscribe(
      data => {
        this.campsites = data;
        this.mapInitializer();
        this.selected = null;
      },
      fail => {
        console.error('CampsiteComponent.index(): error retrieving campsites');
        console.error(fail);
      }
    );

  }

  onSubmit(campsite){
    this.selected = campsite;
  }

  loadCampsite(){
    this.campsiteService.index().subscribe(
      data => this.campsites = data,
      err => console.error('Observer got an error: ' + err)


    );

  }
// create new camp
  create(newCampsite){
    console.log(this.newCampsite);

    this.campsiteService.create(newCampsite).subscribe(
      data => {
        console.log('creation success');
        this.selected = null;
        this.loadCampsite();


      },
      err => {
        console.log('problem with creation');

      }
    );
  }
// delete campsite
  deleteCampsite(id: number) {
    this.campsiteService.delete(id).subscribe(
      reservation => {
        console.log('reservation delete was successful');
        this.reload();
      },
      fail => {
        console.error('TodoListComponent.index(): error retrieving todos');
        console.error(fail);
      }
    );
  }

  // update campsite information
  updatePassRes(campsite: Campsite){
    console.log(campsite);

    this.selected = campsite;
    this.editCampsite = Object.assign({}, this.selected);
    this.updateCampsite(campsite);
  }

  // update campsite
  updateCampsite(campsite){
    this.campsiteService.update(campsite).subscribe(
      reserve => {console.log('reservation update success');
                  this.reload();
                  this.selected = null;
      },
      fail => {
        console.error('Campsite component error');
      }
    );
  }
  displayAll() {
    this.selected = null;
  }

}
