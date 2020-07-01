package com.skilldistillery.campfree.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "campsite")
public class Campsite {

	// Class fields
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String location;
	private Double latitude;
	private Double longitude;

	@ManyToOne
	@JoinColumn(name = "state_id")
	private State state;
	
	
	@OneToMany(mappedBy = "campsite")
	@JsonIgnoreProperties("campsite")
	private List<Comment> comments;
	
	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	@CreationTimestamp
	@Column(name = "creation_date")
	// TODO: AutoGenerate
	private LocalDateTime creationTime;

	@OneToOne
	@JoinColumn(name = "creator_id")
	private Person creator;
	
	@ManyToMany(cascade=CascadeType.PERSIST)
	@JoinTable(name = "campsite_has_feature", joinColumns = @JoinColumn(name = "campsite_id"), inverseJoinColumns = @JoinColumn(name = "feature_id"))
	private List<Feature> features;
	
	private boolean enabled;

	@Column(name = "picture_url")
	private String pictureUrl;

	public Campsite(int id, String name, String location, Double latitude, Double longitude, State state,
			LocalDateTime creationTime, Person creator, List<Feature> features, boolean enabled, String pictureUrl) {
		super();
		this.id = id;
		this.name = name;
		this.location = location;
		this.latitude = latitude;
		this.longitude = longitude;
		this.state = state;
		this.creationTime = creationTime;
		this.creator = creator;
		this.features = features;
		this.enabled = enabled;
		this.pictureUrl = pictureUrl;
	}

	public Campsite() {
		super();
	}

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

	public Person getCreator() {
		return creator;
	}

	public void setCreator(Person creator) {
		this.creator = creator;
	}

	public List<Feature> getFeatures() {
		return features;
	}

	public void setFeatures(List<Feature> features) {
		this.features = features;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
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
		Campsite other = (Campsite) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Campsite [id=" + id + ", name=" + name + ", location=" + location + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", state=" + state + ", creationTime=" + creationTime + " enabled="
				+ enabled + ", pictureUrl=" + pictureUrl + "]";
	}

}
