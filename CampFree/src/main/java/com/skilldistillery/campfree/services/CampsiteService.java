package com.skilldistillery.campfree.services;

import java.util.List;

import com.skilldistillery.campfree.entities.Campsite;

public interface CampsiteService {
	
	Campsite campsiteById(int id);
	Campsite create(Campsite campsite);
	Boolean delete(int id);
	Campsite update(Campsite campsite, int id);
	List<Campsite> findAllCampsites();
	List<Campsite> findCampsiteByName(String keyword);

}
