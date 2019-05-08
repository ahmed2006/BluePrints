/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * This class represents a building entity in the database, which 
 * keeps track of its name and the person who created it.
 */
@Entity
@Table(name = "building")
public class Building {

	
	/** Keeps track of the buidling's id. */
	@Id
	@Column(name = "building_id")
	private UUID id;
	
	/** Keeps track of the name of the building. */
	@Column(name = "name")
	private String name;
	
	/** Keeps track of the user who created the building. */
	@NotFound(action = NotFoundAction.IGNORE)
	@ManyToOne
	@JoinColumn(name = "created_by")
	private AppUser creator;
	
	
	/**
	 * Creates a building and initializes it's fields.
	 */
	public Building() {
		id = null;
		name = null;
		creator = null;
	}
	
	/**
	 * Creates a new building with the provided name, and assigns which user is creating it.
	 * 
	 * @param newName - the name of the building being created.
	 * @param newCreator - the user creating this new building.
	 */
	public Building(String newName, AppUser newCreator) {
		id = UUID.randomUUID();
		name = newName;
		creator = newCreator;
	}

	/**
	 * Returns the name of the building.
	 * 
	 * @return the name of the building.
	 */
	public String getName() {
		return name;
	}

	/**
	 * Changes the name of the building to the new name provided.
	 * 
	 * @param name - the new name for the building.
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Returns the unique ID for the building. 
	 * 
	 * @return the building's ID.
	 */
	public UUID getId() {
		return id;
	}

	/**
	 * Returns the user who created the building. 
	 * 
	 * @return the creator of the building.
	 */
	public AppUser getCreator() {
		return creator;
	}
	
	
	
}
