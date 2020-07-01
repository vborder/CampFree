package com.skilldistillery.campfree.services;

import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.campfree.entities.Campsite;
import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.Picture;
import com.skilldistillery.campfree.entities.State;
import com.skilldistillery.campfree.entities.User;
import com.skilldistillery.campfree.repositories.PersonRepository;
import com.skilldistillery.campfree.repositories.StateRepository;
import com.skilldistillery.campfree.repositories.UserRepository;

@Service
public class PersonServiceImpl implements PersonService{
	
	@Autowired
	private PersonRepository peRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private StateRepository stateRepo;

	@Override
	public Person findById(int id) {
		return peRepo.findById(id);
		
	}

	@Override
	public Person create(String username, Person person) {
		User user = userRepo.findByUsername(username);
		person = peRepo.findByUserUsername(username);
		State personState = person.getState();
		personState = stateRepo.findByName(personState.getName());
		
		if (personState != null && user != null) { //&& user != null
			person.setState(personState);
			person.setUser(user);
			return peRepo.saveAndFlush(person);

		}
		
		return null;
	}

//	@Override
//	public Boolean delete(int id) {
//		boolean deleted = false;
//		
//		try {
//			peRepo.delete(id);
//			deleted = true;
//	} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return deleted;
//		
//	}

	@Override
	public Person update(String username, Person person, int id) {
		Person personUpdated = peRepo.findByUserUsername(username);
		
		if (personUpdated != null) {
			personUpdated.setEmail(person.getEmail());
			personUpdated.setFirstName(person.getFirstName());
			personUpdated.setLastName(person.getLastName());
			personUpdated.setProfileImage(person.getProfileImage());
			personUpdated.setBio(person.getBio());
			peRepo.saveAndFlush(personUpdated);
			return personUpdated;
		}
		
		return null;
	}

	@Override
	public Person findByUsername(String username) {
		// TODO Auto-generated method stub
		return peRepo.findByUserUsername(username);
	}


//	@Override
//	public Set<Picture> userIndex(String username) {
//		return peRepo.findByPerson_UserUsername(username);
//	}
	
	

}
