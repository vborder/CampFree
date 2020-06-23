package com.skilldistillery.campfree.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class State {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String abbreviation;
	private String name;
	
	
	//toString
	@Override
	public String toString() {
		return "State [id=" + id + ", abbreviation=" + abbreviation + ", name=" + name + "]";
	}
	
	
	//Constructors
	public State() {
		super();
	}
	public State(int id, String abbreviation, String name) {
		super();
		this.id = id;
		this.abbreviation = abbreviation;
		this.name = name;
	}
	
	
	//Hash and Equals
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		State other = (State) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	//Getters and Setters
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAbbreviation() {
		return abbreviation;
	}
	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	

}
