package com.skilldistillery.campfree.services;

import java.util.List;

import com.skilldistillery.campfree.entities.Comment;

public interface CommentService {
	Comment createComment(Comment comment);
	Comment updateComment(Comment comment, int id);
	Boolean deleteComment(int id);
	List<Comment> getAllCommentsByCampsiteId(int campsiteId);

}
