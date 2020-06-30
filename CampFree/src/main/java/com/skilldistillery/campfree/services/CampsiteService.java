package com.skilldistillery.campfree.services;

import java.util.List;
import java.util.Set;

import com.skilldistillery.campfree.entities.Campsite;
import com.skilldistillery.campfree.entities.Feature;

public interface CampsiteService {
	Campsite findCampsiteById(String username, int campsiteId);
	List<Campsite> findAllCampsites();
	Campsite createCampsite(String username, Campsite campsite);
	Campsite updateCampsite(String username,Campsite campsite, int campsiteId);
	boolean disableCampsite(String username, int campsiteId);
	List<Campsite> findByName(String name);
	public Set<Campsite> userIndex(String username);
	List<Feature> findAll();

}
