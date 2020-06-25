package com.skilldistillery.campfree.services;

import com.skilldistillery.campfree.entities.Comment;

public interface CommentService {
	
	Comment updateComment(Comment comment, int id);
	Boolean deleteComment(int id);

}
