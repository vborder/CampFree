package com.skilldistillery.campfree.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Campsite;

public interface CampsiteRepository extends JpaRepository<Campsite, Integer>{
	List<Campsite> findAll();
	void delete (Campsite campsite);
	List<Campsite> findByName(String name);

}
