package com.skilldistillery.campfree.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import com.skilldistillery.campfree.entities.User;
import com.skilldistillery.campfree.repositories.UserRepository;

@Service
@CrossOrigin({"*", "http://localhost:4210"})
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public User register(User user) {
		String encodedPW = encoder.encode(user.getPassword());
		user.setPassword(encodedPW); // only persist encoded password

		// set other fields to default values
		user.setEnabled(true);
		user.setRole("user"); // may chacnge this to "standard"
		
		
		userRepo.saveAndFlush(user);
		return user;
	}

}
