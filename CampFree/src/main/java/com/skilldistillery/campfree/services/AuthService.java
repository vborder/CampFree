package com.skilldistillery.campfree.services;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.User;

public interface AuthService {
	
	public User register (Person person);

}
