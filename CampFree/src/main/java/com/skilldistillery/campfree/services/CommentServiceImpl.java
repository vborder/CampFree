package com.skilldistillery.campfree.services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.campfree.entities.Campsite;
import com.skilldistillery.campfree.entities.Comment;
import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.repositories.CampsiteRepository;
import com.skilldistillery.campfree.repositories.CommentRepository;
import com.skilldistillery.campfree.repositories.PersonRepository;

@Service
public class CommentServiceImpl implements CommentService{

	@Autowired
	private CommentRepository commentRepo;
	
	@Autowired
	private CampsiteRepository campRepo;
	
	@Autowired
	private PersonRepository perRepo;
	
	@Override
	public Comment updateComment(Comment comment, int id) {
		Optional<Comment> commentOpt= commentRepo.findById(id);
		Comment newerComment= null;
		if(commentOpt.isPresent()) {
			newerComment= commentOpt.get();
			newerComment.setCampsiteRating(comment.getCampsiteRating());
			newerComment.setRemark(comment.getRemark());
			newerComment.setCreatedDateTime(LocalDateTime.now());
			newerComment.setEnabled(comment.isEnabled());
		}
		return newerComment;
		
	}

	@Override
	public Boolean deleteComment(int id) {
		Optional<Comment> commentOpt= commentRepo.findById(id);
		if(commentOpt.isPresent()) {
			Comment deleteThis= commentOpt.get();
			deleteThis.setEnabled(false);
			commentRepo.saveAndFlush(deleteThis);
			return true;
		}
		else {
			return false;
		}
		
	}

	@Override
	public Comment createComment(Comment comment, int cid, String username) {
		Optional<Campsite> campOpt = campRepo.findById(cid);
		if(campOpt.isPresent()) {
			Person person = perRepo.findByUserUsername(username);
			Campsite campsite = campOpt.get();
			comment.setCampsite(campsite);
			comment.setPerson(person);
			return commentRepo.saveAndFlush(comment);
			
		}
		
		return null;
	}

	@Override
	public List<Comment> getAllCommentsByCampsiteId(int campsiteId) {
		List<Comment> comments= commentRepo.findByCampsite_Id(campsiteId);
		return comments;
	}

}
