package com.skilldistillery.campfree.services;

import java.util.List;
import com.skilldistillery.campfree.entities.Campsite;

public interface CampsiteService {
	Campsite findCampsiteById(String username, int campsiteId);
	List<Campsite> findAllCampsites();
	Campsite createCampsite(String username, Campsite campsite);
	Campsite updateCampsite(String username,Campsite campsite, int campsiteId);
	boolean disableCampsite(String username, int campsiteId);
	List<Campsite> findByName(String name);
}
