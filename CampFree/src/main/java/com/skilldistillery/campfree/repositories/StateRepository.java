package com.skilldistillery.campfree.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.State;



public interface StateRepository extends JpaRepository<State, Integer> {
	State findByName(String name);

}
