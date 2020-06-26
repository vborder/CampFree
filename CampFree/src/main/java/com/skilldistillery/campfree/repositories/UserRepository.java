package com.skilldistillery.campfree.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findByUsername(String username);

}
