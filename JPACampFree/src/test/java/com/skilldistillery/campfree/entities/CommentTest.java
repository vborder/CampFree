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

class CommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
		comment = em.find(Comment.class,1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	@Test
	void test() {
		assertNotNull(comment);
		assertEquals(1, comment.getId());
		LocalDateTime time = comment.getCreatedDateTime();
		assertEquals(2020, time.getYear());
		assertEquals(5, time.getMonthValue());
		assertEquals(26, time.getDayOfMonth());
		assertEquals("This is one of my favorite spots.", comment.getRemark());
		assertEquals(5, comment.getCampsiteRating());
		assertTrue(comment.isEnabled());
		assertEquals(1, comment.getCampsite().getId());
		assertEquals(1, comment.getPerson().getId());
	}

}
