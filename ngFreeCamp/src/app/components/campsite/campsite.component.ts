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

  selected: Campsite = null;
  editCampsite = null;
  newCampsite = new Campsite();
  campsites: Campsite [] = [];


  title = 'angular-gmap';
  @ViewChild('mapContainer', { static: false }) gmap: ElementRef;
  map: google.maps.Map;
  lat = 40.73061;
  lng = -73.935242;

  coordinates = new google.maps.LatLng(this.lat, this.lng);

  mapOptions: google.maps.MapOptions = {
   center: this.coordinates,
   zoom: 8
  };

  marker = new google.maps.Marker({
    position: this.coordinates,
    map: this.map,
  });

  images = [
    'https://images.pexels.com/photos/3232542/pexels-photo-3232542.jpeg?auto=compress&cs=tinysrgb&dpr=1',
    'https://images.pexels.com/photos/1118785/pexels-photo-1118785.jpeg?auto=compress&cs=tinysrgb&dpr=1',
    'https://images.pexels.com/photos/618848/pexels-photo-618848.jpeg?auto=compress&cs=tinysrgb&dpr=1'

  ];

  ngAfterViewInit() {
    this.mapInitializer();
  }

  mapInitializer() {
    this.map = new google.maps.Map(this.gmap.nativeElement,
    this.mapOptions);
    this.marker.setMap(this.map);
  }

  ngOnInit(): void {
      this.reload();
  }

  reload(){
    console.log('reloading');

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

  create(){
    console.log(this.newCampsite);

    this.campsiteService.create(this.newCampsite).subscribe(
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
    // this.reload();
  }

  // update campsite
  updateReservation(campsite){
    this.campsiteService.update(Campsite).subscribe(
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
