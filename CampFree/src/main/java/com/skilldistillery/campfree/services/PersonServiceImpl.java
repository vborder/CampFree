package com.skilldistillery.campfree.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.repositories.PersonRepository;

@Service
public class PersonServiceImpl implements PersonService{
	
	@Autowired
	private PersonRepository peRepo;

	@Override
	public Person findById(int id) {
		return peRepo.findById(id);
		
	}

	@Override
	public Person create(Person person) {
		return peRepo.saveAndFlush(person);

	}

	@Override
	public Boolean delete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Person update(Person person, int id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
