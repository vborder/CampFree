package com.skilldistillery.campfree.services;

import com.skilldistillery.campfree.entities.Person;

public interface PersonService {

	Person findById(int id); // may change method name in future
	Person create(Person person);
	Person update(Person person, int id);
	Boolean delete(int id);
	
	
}
