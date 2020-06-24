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
	public Person personById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Person create(Person person) {
		// TODO Auto-generated method stub
		return null;
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
