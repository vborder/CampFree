package com.skilldistillery.campfree.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Person;

public interface PersonRepository extends JpaRepository<Person, Integer> {
	
	
	
	

}
