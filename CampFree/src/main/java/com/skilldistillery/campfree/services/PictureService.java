package com.skilldistillery.campfree.services;

import java.util.Set;

import com.skilldistillery.campfree.entities.Picture;

public interface PictureService {
	Picture findById(int id); 
	Picture create(Picture picture);
	Picture update(Picture picture, int id);
	Boolean delete(int id);
	public Set<Picture> userIndex(String username);

}
