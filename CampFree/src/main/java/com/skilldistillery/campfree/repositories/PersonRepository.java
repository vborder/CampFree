package com.skilldistillery.campfree.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.Picture;

public interface PersonRepository extends JpaRepository<Person, Integer> {
	Person findById(int id);
	void delete(Person person);
//	Set<Picture> findById_UserUsername(String username);

}
