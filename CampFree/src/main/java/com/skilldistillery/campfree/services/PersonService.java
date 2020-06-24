package com.skilldistillery.campfree.services;

import com.skilldistillery.campfree.entities.Person;

public interface PersonService {

	
	Person personById(int id);
	Person create(Person person);
	Boolean delete(int id);
	Person update(Person person, int id);
	
	
}
