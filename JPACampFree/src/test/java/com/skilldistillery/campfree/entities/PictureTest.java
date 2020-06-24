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

class PictureTest {

	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Picture pic;

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
		pic = em.find(Picture.class,1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		pic = null;
	}

	@Test
	void test() {
		assertNotNull(pic);
		assertEquals(1, pic.getId());
		assertEquals("https://www.alltrails.com/trail/us/colorado/ute-creek-trail/photos", pic.getImageURL());
		assertTrue(pic.isEnabled());
		LocalDateTime time = pic.getCreationDate();
		assertEquals(2020, time.getYear());
		assertEquals(5, time.getMonthValue());
		assertEquals(27, time.getDayOfMonth());
		assertEquals(1, pic.getPerson().getId());		
		assertEquals(1, pic.getCampsite().getId());		
	}
}
