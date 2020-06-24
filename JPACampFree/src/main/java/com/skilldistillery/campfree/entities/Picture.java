package com.skilldistillery.campfree.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Picture {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	@Column(name="image_url")
	private String imageURL;
	private boolean enabled;
	//TODO AutoGenerate
	@CreationTimestamp
	@Column(name="creation_date")
	private LocalDateTime creationDate;
	@ManyToOne
	@JoinColumn(name="person_user_id")
	private Person person;
	@ManyToOne
	@JoinColumn(name="campsite_id")
	private Campsite campsite;
	
	
	
	@Override
	public String toString() {
		return "Picture [id=" + id + ", imageURL=" + imageURL + ", enabled=" + enabled + ", creationDate="
				+ creationDate + ", campsite=" + campsite + "]";
	}
	
	
	public Picture() {
		super();
	}
	public Picture(int id, String imageURL, boolean enabled, LocalDateTime creationDate, Person person,
			Campsite campsite) {
		super();
		this.id = id;
		this.imageURL = imageURL;
		this.enabled = enabled;
		this.creationDate = creationDate;
		this.person = person;
		this.campsite = campsite;
	}
	
	
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
		Picture other = (Picture) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getImageURL() {
		return imageURL;
	}
	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public LocalDateTime getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(LocalDateTime creationDate) {
		this.creationDate = creationDate;
	}
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
	public Campsite getCampsite() {
		return campsite;
	}
	public void setCampsite(Campsite campsite) {
		this.campsite = campsite;
	}
	
	
	
}
