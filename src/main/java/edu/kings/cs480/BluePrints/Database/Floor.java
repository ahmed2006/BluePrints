package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 * This class represents a entry for the floor table in the BluePrints
 * database.
 */
@Entity
@Table(name = "floor")
public class Floor {

	/** Keeps track of the primary key for the floor. */
	@Id
	@Column(name = "floor_id")
	private UUID id;

	/** Keeps track of the floors name. */
	@Column(name = "floor_name")
	private String floorName;

	/** Keeps track of the building this floor belongs to. */
	@ManyToOne
	@JoinColumn(name = "building_id")
	private Building building;

	/**
	 * Creates a new floor with the provided id number and .
	 * 
	 */
	public Floor(Building building, String newFloorName) {
        id = UUID.randomUUID();
        this.building = building;
        floorName = newFloorName;
}

	/**
	 * Creates a new instance of Floor and initializes it's fields.
	 */
	public Floor() {
		id = null;
        building = null;
        floorName = null;
        
	}

	/**
	 * Return's the user's unique id.
	 * 
	 * @return the unique id for the user.
	 */
	public UUID getId() {
		return id;
	}
	

	/**
	 * This method returns the name of the floor.
	 * 
	 * @return the name of the floor.
	 */
	public String getName() {
		return floorName;
	}

	/**
	 * This method returns the building this 
	 * floor belongs to.
	 * 
	 * @return the building this floor belongs to.
	 */
	public Building getBuilding() {
		return building;
	}
    
}