package com.skilldistillery.campfree.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class PersonTest {

	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Person person;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("CampFreePU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		person = em.find(Person.class,1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		person = null;
	}

	@Test
	void test() {
		assertNotNull(person);
		assertEquals(1, person.getId());
		assertEquals("adminguy@gmail.com", person.getEmail());
		assertEquals("Steven", person.getFirstName());
		assertEquals("Pinker", person.getLastName());
		assertEquals("1", person.getProfileImage());
		assertEquals("Just a camper trying to find great sites", person.getBio());
		assertEquals(1, person.getUser().getId());
		assertEquals(1, person.getState().getId());
	}

}
