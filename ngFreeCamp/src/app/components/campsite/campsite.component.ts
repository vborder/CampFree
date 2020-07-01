// import { Component, OnInit } from '@angular/core';
import {
  Component,
  OnInit,
  AfterViewInit,
  ViewChild,
  ElementRef,
} from '@angular/core';
import { Campsite } from 'src/app/models/campsite';
import { CampsiteService } from 'src/app/services/campsite.service';
import { State } from 'src/app/models/state';
import { features } from 'process';

@Component({
  selector: 'app-campsite, ngbd-carousel-basic',
  templateUrl: './campsite.component.html',
  styleUrls: ['./campsite.component.css'],
})
export class CampsiteComponent implements OnInit, AfterViewInit {
  constructor(private campsiteService: CampsiteService) {}
  select = null;
  selected = null;
  editCampsite = null;
  newCampsite = new Campsite();
  campsites: Campsite[] = [];
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
    'https://images.pexels.com/photos/3232542/pexels-photo-3232542.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=750&w=1260',
    'https://images.pexels.com/photos/1118785/pexels-photo-1118785.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=750&w=1260',
    'https://images.pexels.com/photos/618848/pexels-photo-618848.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=750&w=1260',
    'https://images.pexels.com/photos/803226/pexels-photo-803226.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://images.pexels.com/photos/207324/pexels-photo-207324.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
  ];

  newCampsiteFeatures = [];
  featuresForNewCampsite = [];

  newCampsiteState: State = new State();

  title = 'angular-gmap';
  @ViewChild('mapContainer', { static: false }) gmap: ElementRef;
  map: google.maps.Map;
  lat = 39.7392;
  lng = -104.9903;

  markers: google.maps.Marker[] = [];

  mapOptions: google.maps.MapOptions = {
    center: new google.maps.LatLng(this.lat, this.lng),
    zoom: 3,
  };

  mapInitializer() {
    this.campsiteService.index().subscribe(
      (data) => {
        this.campsites = data;

        this.selected = null;
      },
      (fail) => {
        console.error('CampsiteComponent.index(): error retrieving campsites');
        console.error(fail);
      }
    );
    this.map = new google.maps.Map(this.gmap.nativeElement, this.mapOptions);

    console.log(this.campsites);

    this.campsites.forEach((val) => {
      if(val.enabled){
      const contentString =
        '<div>' +
        '<h4>' +
        val.name +
        '</h4>' +
        '<h6>' +
        val.latitude +
        '  :  ' +
        val.longitude +
        '</h6>' +
        '<h5>' +
        val.state.name +
        '</h5>' +
        "<img src='" +
        val.pictureUrl +
        "' width='120' height='100' />" +
        '</div>';
      const coordinates = new google.maps.LatLng(val.latitude, val.longitude);
      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        maxWidth: 400,
      });

      const marker = new google.maps.Marker({
        position: coordinates,
        icon: 'http://maps.google.com/mapfiles/ms/micons/campground.png',
        map: this.map,
        // title: val.name
      });

      marker.addListener('click', () => {
        this.selected = val;
        this.closeOtherInfo();
        infowindow.open(this.map, marker);
        // infowindow.close();
        this.InforObj[0] = infowindow;
      });

      marker.setMap(this.map);

    }
    });
  }

  closeOtherInfo() {
    if (this.InforObj.length > 0) {
      /* detach the info-window from the marker ... undocumented in the API docs */
      this.InforObj[0].set('marker', null);
      /* and close it */
      this.InforObj[0].close();
      /* blank the array */
      this.InforObj.length = 0;
    }
  }

  ngAfterViewInit() {
    this.mapInitializer();
  }

  toggleCCamp() {
    this.showCCamp = !this.showCCamp;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCamps = null;
    this.showECamp = null;
  }

  toggleECamp(campsiteEdit) {
    this.showECamp = !this.showECamp;
    this.editCampsite = campsiteEdit;
    this.newCampsiteState = campsiteEdit.state;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCamps = null;
    this.showCCamp = null;
  }

  toggleCamps() {
    this.showCamps = !this.showCamps;
    this.selected = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleAComs() {
    this.showAComs = !this.showAComs;
    this.selected = null;
    this.showCamps = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleEComs() {
    this.showEComs = !this.showEComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showDComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleDComs() {
    this.showDComs = !this.showDComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showCComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  toggleCComs() {
    this.showCComs = !this.showDComs;
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCCamp = null;
    this.showECamp = null;
  }

  clearPage() {
    this.selected = null;
    this.showCamps = null;
    this.showAComs = null;
    this.showEComs = null;
    this.showDComs = null;
    this.showCCamp = null;
    this.showECamp = null;
    this.showCComs = null;
  }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    console.log('reloading');

    this.campsiteService.index().subscribe(
      (data) => {
        this.campsites = data;
        this.mapInitializer();
        this.selected = null;
        this.clearPage();
      },
      (fail) => {
        console.error('CampsiteComponent.index(): error retrieving campsites');
        console.error(fail);
      }
    );
    this.campsiteService.indexFeature().subscribe(
      (data) => {
        this.newCampsiteFeatures = data;
        this.selected = null;
      },
      (fail) => {
        console.error('Features.index(): error retrieving campsites Features');
        console.error(fail);
      }
    );
  }

  onSubmit(campsite) {
    this.selected = campsite;
  }

  loadCampsite() {
    this.campsiteService.index().subscribe(
      (data) => (this.campsites = data),
      (err) => console.error('Observer got an error: ' + err)
    );
  }


  addFeatureToCampsite(feature) {
    this.featuresForNewCampsite.push(feature);
  }

  // create new campsite
  create(newCampsite, campsiteState) {
    console.log(this.newCampsite);
    newCampsite.state = campsiteState;
    newCampsite.features = this.featuresForNewCampsite;
    console.log(newCampsite);
    console.log(features);

    this.campsiteService.create(newCampsite).subscribe(
      (data) => {
        console.log('creation success');
        this.selected = null;
        this.loadCampsite();
        // this.ngAfterViewInit();
      },
      (err) => {
        console.log('problem with creation');
      }
    );
  }

  // delete campsite
  deleteCampsite(id: number) {
    console.log(this.selected.id);
    this.campsiteService.delete(this.selected.id).subscribe(
      (data) => {
        console.log('campsite delete was successful');
        this.reload();
      },
      (fail) => {
        console.error('DELETE ERRORS');
        console.error(fail);
      }
    );
  }

  // update campsite information
  updatePassRes(campsite: Campsite) {
    console.log(campsite);

    this.selected = campsite;

    this.newCampsite.features = this.featuresForNewCampsite;
    this.editCampsite = Object.assign({}, this.selected);
    campsite.state = this.newCampsiteState;
    campsite.features = this.featuresForNewCampsite;

    this.updateCampsite(campsite);
  }

  // update campsite
  updateCampsite(campsite) {
    this.campsiteService.update(campsite).subscribe(
      (reserve) => {
        console.log('campsite update success');
        this.reload();
        this.selected = null;
      },
      (fail) => {
        console.error('Campsite component error');
      }
    );
  }
  displayAll() {
    this.selected = null;
  }
}
