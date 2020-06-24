package com.skilldistillery.campfree.entities;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDateTime;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CampsiteTest {

	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Campsite campsite;

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
		campsite = em.find(Campsite.class,1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		campsite = null;
	}

	@Test
	void test() {
		assertNotNull(campsite);
		assertEquals(1, campsite.getId());
		assertEquals("Ute Creek", campsite.getName());
		assertEquals("Colorado", campsite.getLocation());
		assertEquals(37.76053, campsite.getLatitude());
		assertEquals(-107.34258, campsite.getLongitude());
		assertTrue(campsite.isEnabled());
//		assertEquals(1, campsite.getCreator().getId());
		LocalDateTime time = campsite.getCreationTime();
		assertEquals(2020, time.getYear());
		assertEquals(5, time.getMonthValue());
		assertEquals(27, time.getDayOfMonth());
		assertEquals(1, campsite.getState().getId());
		assertEquals("https://www.pexels.com/photo/six-camping-tents-in-forest-699558/", campsite.getPictureUrl());
		assertEquals(1, campsite.getFeatures().size());
//		assertEquals(1, campsite.getCreator().getId());
	}

}
