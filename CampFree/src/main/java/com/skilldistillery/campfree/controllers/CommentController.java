package com.skilldistillery.campfree.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.campfree.entities.Comment;
import com.skilldistillery.campfree.services.CommentService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost:4210"})
public class CommentController {
	
	@Autowired
	private CommentService comSvc;

//	delete a 
	@DeleteMapping("comment/{id}")
	public void deleteComment(
			@PathVariable Integer id,
			HttpServletResponse response) {
		try {
			if(comSvc.deleteComment(id)) {
			response.setStatus(204);
			}else {
				response.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(409);
		}
	}
	
	@PutMapping("comment/{id}")
	public Comment update(
			@PathVariable Integer id, 
			@RequestBody Comment comment, 
			HttpServletResponse response) {
		try {
			comment = comSvc.updateComment(comment, id);
			if (comment == null) {
				response.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			comment = null;
		}
		return comment;
	}
	
	
}
