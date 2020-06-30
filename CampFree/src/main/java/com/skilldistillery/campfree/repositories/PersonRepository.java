package com.skilldistillery.campfree.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Person;

public interface PersonRepository extends JpaRepository<Person, Integer> {
	Person findById(int id);
	void delete(Person person);
	Person findByUserUsername(String username);

}
