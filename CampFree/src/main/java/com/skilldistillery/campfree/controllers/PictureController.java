package com.skilldistillery.campfree.controllers;

import java.security.Principal;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.Picture;
import com.skilldistillery.campfree.services.PictureService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4210" })
public class PictureController {
	
	@Autowired
	private PictureService picSvc;
	
//	get picture by Id
	@GetMapping("picture/{id}")
	public Picture pictureById(@PathVariable Integer id, HttpServletResponse req, HttpServletResponse res,
			Principal principal) {
		Picture picture = picSvc.findById(id);
		if (picture == null) {
			res.setStatus(404);
		}
		return picture;
	}
	
	// retrieve pictures by username
	@GetMapping("person/userPictures")
	public Set<Picture> findByUsername(
			HttpServletResponse response,
			HttpServletRequest request,
			Principal principal
			) {
		Set<Picture> pictures = picSvc.userIndex(principal.getName());
		
		if (pictures == null) {
			response.setStatus(404);
		}
		return pictures;
	}

}
