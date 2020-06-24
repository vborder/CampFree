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

class StateTest {

	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private State state;

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
		state = em.find(State.class,1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		state = null;
	}

	@Test
	void test() {
		assertNotNull(state);
		assertEquals(1, state.getId());
		assertEquals("CO", state.getAbbr());
		assertEquals("Colorado", state.getName());
	}
}
