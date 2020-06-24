package com.skilldistillery.campfree.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name= "comment")
public class Comment {
	
	//Class Fields
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	@Column(name="comment_date")
	private LocalDateTime createdDateTime;
	private String remark;
	@ManyToOne
	@JoinColumn(name= "campsite_id")
	private Campsite campsite;
	@ManyToOne
	@JoinColumn(name= "person_id")
	private Person person;
	private boolean enabled;
	@Column(name= "campsite_rating")
	private Integer campsiteRating;
	//Stretch private Integer helpfulnessRating;
	
	

	
	//toString
	@Override
	public String toString() {
		return "Comment [id=" + id + ", createdDateTime=" + createdDateTime + ", remark=" + remark + ", campsite="
				+ campsite + ", person=" + person + ", enabled=" + enabled + ", campsiteRating=" + campsiteRating
				+ ", helpfulnessRating="  + "]";
	}
	
	
	//Constructors
	public Comment() {
		super();
	}
	public Comment(int id, LocalDateTime createdDateTime, String remark, Campsite campsite, Person person,
			boolean enabled, Integer campsiteRating) {
		super();
		this.id = id;
		this.createdDateTime = createdDateTime;
		this.remark = remark;
		this.campsite = campsite;
		this.person = person;
		this.enabled = enabled;
		this.campsiteRating = campsiteRating;
		//this.helpfulnessRating = helpfulnessRating;
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
//	public Integer getCampsiteRating() {
//		return campsiteRating;
//	}
//	public Integer getHelpfulnessRating() {
//		return helpfulnessRating;
//	}


	public Integer getCampsiteRating() {
		return campsiteRating;
	}


	public void setCampsiteRating(Integer campsiteRating) {
		this.campsiteRating = campsiteRating;
	}


	public void setId(int id) {
		this.id = id;
	}


	public void setCreatedDateTime(LocalDateTime createdDateTime) {
		this.createdDateTime = createdDateTime;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public void setCampsite(Campsite campsite) {
		this.campsite = campsite;
	}


	public void setPerson(Person person) {
		this.person = person;
	}


	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	
	
	

}
