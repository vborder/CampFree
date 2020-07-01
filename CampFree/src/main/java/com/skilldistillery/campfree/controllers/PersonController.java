package com.skilldistillery.campfree.controllers;

import java.security.Principal;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.campfree.entities.Person;
import com.skilldistillery.campfree.entities.Picture;
import com.skilldistillery.campfree.services.PersonService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4210" })
public class PersonController {

	@Autowired
	private PersonService perSvc;

//	get person by Id
	@GetMapping("person/{id}")
	public Person personById(@PathVariable Integer id, HttpServletResponse req, HttpServletResponse res,
			Principal principal) {
		Person person = perSvc.findById(id);
		if (person == null) {
			res.setStatus(404);
		}
		return person;
	}
	
	@GetMapping("person/username")
	public Person personById(HttpServletResponse req, HttpServletResponse res,
			Principal principal) {
		Person person = perSvc.findByUsername(principal.getName());
		if (person == null) {
			res.setStatus(404);
		}
		return person;
	}
	
//	// retrieve pictures by username
//	@GetMapping("person/userPictures")
//	public Set<Picture> findByUsername(
//			HttpServletResponse response,
//			HttpServletRequest request,
//			Principal principal
//			) {
//		Set<Picture> pictures = perSvc.userIndex(principal.getName());
//		
//		if (pictures == null) {
//			response.setStatus(404);
//		}
//		return pictures;
//	}

//	 create Person
	@PostMapping("person")
	public Person create(
			@RequestBody Person person, 
			HttpServletRequest req, 
			HttpServletResponse res,
			Principal principal
			) {

		try {
			person = perSvc.create(principal.getName(), person);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(person.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			person = null;
		}
		return person;
	}

//  update a person
	@PutMapping("person/{id}")
	public Person update(HttpServletResponse res,
			HttpServletRequest req,
			Principal principal,
			@PathVariable Integer id,
			@RequestBody Person person
			) {
		try {
			person = perSvc.update(principal.getName(), person, id);
			if (person == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			person = null;
		}
		return person;
	}
	
//	delete a person
//	@DeleteMapping("person/{id}")
//	public void delete(@PathVariable Integer id, HttpServletResponse response) {
//		try {
//			if (perSvc.delete(id)) {
//				response.setStatus(204);
//			} else {
//				response.setStatus(404);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			response.setStatus(409);
//		}
//	}
	

}
