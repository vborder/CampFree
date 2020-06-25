package com.skilldistillery.campfree.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.campfree.entities.User;
import com.skilldistillery.campfree.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost:4210"})
public class UserController {
	
	@Autowired
	private UserService useSvc;
	
	
//	Post User Update
	@PutMapping("user/{id}")
	public User updateUser(
			@PathVariable Integer id,
			@RequestBody User user,
			HttpServletRequest req,
			HttpServletResponse res,
			Principal principal) {
		
			try {
				user = useSvc.updateUser(user, id);
				if(user == null) {
					res.setStatus(404);
				}
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
				user = null;
			}
			return user; }
		
		
	}


