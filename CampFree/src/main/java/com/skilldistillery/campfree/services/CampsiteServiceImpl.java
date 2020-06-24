package com.skilldistillery.campfree.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.campfree.entities.Campsite;
import com.skilldistillery.campfree.repositories.CampsiteRepository;

@Service
public class CampsiteServiceImpl implements CampsiteService{
	
	@Autowired
	private CampsiteRepository campRepo;

	@Override
	public Campsite campsiteById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Campsite create(Campsite campsite) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean delete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Campsite update(Campsite campsite, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Campsite> findAllCampsites() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Campsite> findCampsiteByName(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

}
