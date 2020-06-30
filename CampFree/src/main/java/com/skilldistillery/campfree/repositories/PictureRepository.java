package com.skilldistillery.campfree.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Picture;

public interface PictureRepository extends JpaRepository<Picture, Integer>{
	Picture findById(int id);
	void delete(Picture picture);
	Set<Picture> findByPerson_UserUsername(String username);

}
