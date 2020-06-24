package com.skilldistillery.campfree.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Comment {
	
	//Class Fields
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	private LocalDateTime createdDateTime;
	private String remark;
	private Campsite campsite;
	private Person person;
	private boolean enabled;
	@Column(name= "campsite_rating")
	private Integer campsiteRating;
	private Integer helpfulnessRating;
	
	

	
	//toString
	@Override
	public String toString() {
		return "Comment [id=" + id + ", createdDateTime=" + createdDateTime + ", remark=" + remark + ", campsite="
				+ campsite + ", person=" + person + ", enabled=" + enabled + ", campsiteRating=" + campsiteRating
				+ ", helpfulnessRating=" + helpfulnessRating + "]";
	}
	
	
	//Constructors
	public Comment() {
		super();
	}
	public Comment(int id, LocalDateTime createdDateTime, String remark, Campsite campsite, Person person,
			boolean enabled, Integer campsiteRating, Integer helpfulnessRating) {
		super();
		this.id = id;
		this.createdDateTime = createdDateTime;
		this.remark = remark;
		this.campsite = campsite;
		this.person = person;
		this.enabled = enabled;
		this.campsiteRating = campsiteRating;
		this.helpfulnessRating = helpfulnessRating;
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
		Comment other = (Comment) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	//Getters and Setters
	public int getId() {
		return id;
	}
	public LocalDateTime getCreatedDateTime() {
		return createdDateTime;
	}
	public String getRemark() {
		return remark;
	}
	public Campsite getCampsite() {
		return campsite;
	}
	public Person getPerson() {
		return person;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public Integer getCampsiteRating() {
		return campsiteRating;
	}
	public Integer getHelpfulnessRating() {
		return helpfulnessRating;
	}
	
	
	
	

}
