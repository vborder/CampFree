package com.skilldistillery.campfree.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.campfree.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	List<Comment> findByCampsite_Id(int campsiteId);

}
