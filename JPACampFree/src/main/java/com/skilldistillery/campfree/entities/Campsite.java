package com.skilldistillery.campfree.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Campsite {
	
	//Class fields
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	private String name;
	private String location;
	private Double latitude;
	private Double longitude;
	//@ManyToOne()
	private State state;
	@Column(name="creation_date")
	private LocalDateTime creationTime;
	//@OneToOne()
	private User creator;
	private boolean enabled;
	
	
	
	//toString
	@Override
	public String toString() {
		return "Campsite [id=" + id + ", name=" + name + ", location=" + location + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", state=" + state + ", creationTime=" + creationTime + ", creator="
				+ creator + ", enabled=" + enabled + "]";
	}
	
	//Constructors
	public Campsite() {
		super();
	}
	public Campsite(int id, String name, String location, Double latitude, Double longitude, State state,
			LocalDateTime creationTime, User creator, boolean enabled) {
		super();
		this.id = id;
		this.name = name;
		this.location = location;
		this.latitude = latitude;
		this.longitude = longitude;
		this.state = state;
		this.creationTime = creationTime;
		this.creator = creator;
		this.enabled = enabled;
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
		Campsite other = (Campsite) obj;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Double getLatitude() {
		return latitude;
	}
	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}
	public Double getLongitude() {
		return longitude;
	}
	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	public State getState() {
		return state;
	}
	public void setState(State state) {
		this.state = state;
	}
	public LocalDateTime getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(LocalDateTime creationTime) {
		this.creationTime = creationTime;
	}
	public User getCreator() {
		return creator;
	}
	public void setCreator(User creator) {
		this.creator = creator;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	
	
	
	
}
