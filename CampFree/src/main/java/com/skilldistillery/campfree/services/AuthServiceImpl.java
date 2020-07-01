package com.skilldistillery.campfree.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.User;
import com.skilldistillery.campfree.repositories.PersonRepository;
import com.skilldistillery.campfree.repositories.StateRepository;
import com.skilldistillery.campfree.repositories.UserRepository;

@Service
@CrossOrigin({"*", "http://localhost:4210"})
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private PersonRepository perRepo;
	
	@Autowired
	private StateRepository stRepo;

	@Override
	public User register(Person person) {
		person.setState(stRepo.findByName(person.getState().getName()));
		System.out.println(person);
		String encodedPW = encoder.encode(person.getUser().getPassword());
		person.getUser().setPassword(encodedPW); // only persist encoded password

		// set other fields to default values
		person.getUser().setEnabled(true);
		person.getUser().setRole("user"); // may chacnge this to "standard"
		
		userRepo.saveAndFlush(person.getUser());
		perRepo.saveAndFlush(person);
		return person.getUser();
	}
	
	

}
