package com.skilldistillery.campfree.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Campsite;

public interface CampsiteRepository extends JpaRepository<Campsite, Integer>{

}
