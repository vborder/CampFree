// import { Component, OnInit } from '@angular/core';
import {  Component, OnInit, AfterViewInit, ViewChild, ElementRef } from
  '@angular/core';

@Component({
  selector: 'app-campsite, ngbd-carousel-basic',
  templateUrl: './campsite.component.html',
  styleUrls: ['./campsite.component.css']
})
export class CampsiteComponent implements OnInit, AfterViewInit {

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

  ngAfterViewInit() {
    this.mapInitializer();
  }

  mapInitializer() {
    this.map = new google.maps.Map(this.gmap.nativeElement,
    this.mapOptions);
    this.marker.setMap(this.map);
  }

  images = [
    'https://images.pexels.com/photos/3232542/pexels-photo-3232542.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=900',
    'https://images.pexels.com/photos/1118785/pexels-photo-1118785.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=900',
    'https://images.pexels.com/photos/618848/pexels-photo-618848.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=900'

  ];

  constructor() { }

  ngOnInit(): void {

  }



}
