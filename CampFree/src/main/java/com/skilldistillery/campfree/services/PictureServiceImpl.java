package com.skilldistillery.campfree.services;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.campfree.entities.Picture;
import com.skilldistillery.campfree.repositories.PictureRepository;

@Service
public class PictureServiceImpl implements PictureService {
	
	@Autowired
	private PictureRepository picRepo;

	@Override
	public Set<Picture> userIndex(String username) {
		return picRepo.findByPerson_UserUsername(username);
	}

	@Override
	public Picture findById(int id) {
		return picRepo.findById(id);
	}

	@Override
	public Picture create(Picture picture) {
		return picRepo.saveAndFlush(picture);
	}

	@Override
	public Picture update(Picture picture, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean delete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
