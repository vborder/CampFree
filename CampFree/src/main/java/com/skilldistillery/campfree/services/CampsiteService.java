package com.skilldistillery.campfree.services;

import java.util.List;
import com.skilldistillery.campfree.entities.Campsite;

public interface CampsiteService {
	Campsite findCampsiteById(int campsiteId);
	List<Campsite> findAllCampsites();
	Campsite createCampsite(Campsite campsite);
	Campsite updateCampsite(Campsite campsite, int campsiteId);
	boolean disableCampsite(int campsiteId);
	List<Campsite> findByName(String name);
}
