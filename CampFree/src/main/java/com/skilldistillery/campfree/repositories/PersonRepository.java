package com.skilldistillery.campfree.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.Picture;

public interface PersonRepository extends JpaRepository<Person, Integer> {
	Person findById(int id);
	void delete(Person person);
<<<<<<< HEAD
//	Set<Picture> findById_UserUsername(String username);
=======
	Person findByUserUsername(String username);
>>>>>>> fd3ec633a4dd26dca0b03aaf65e6b64140dc7462

}
