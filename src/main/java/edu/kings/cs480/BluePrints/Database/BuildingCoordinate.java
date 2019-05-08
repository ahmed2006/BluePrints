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

/**
 * This class represents coordinates data for a 
 * building. 
 */
@Entity 
@Table(name = "building_coordinate")
public class BuildingCoordinate {
	
	
	/**Keeps track of the id for the building coordinate. */
	@Id
	@Column(name = "coordinate_id")
	private UUID id;
	
	
	/**Keeps track of coordinate data.*/
	@Column(name = "coordinate_data", length = 4000)
	private String coordinateData; 
	
	
	/**Keeps track of the building the coordinate data belongs to.*/
	@ManyToOne
	@JoinColumn(name = "building_id")
	private Building building;
	
	
	/**
	 * Constructs a new BuildingCoordinate and initializes its
	 * fields.
	 */
	public BuildingCoordinate() {
		
		id = null;
		coordinateData = null;
		building = null;
	}
	
	/**
	 * Constructs a new BuildingCoordinate and initializes its
	 * fields.
	 */
	public BuildingCoordinate(Building newBuilding, String coordinates) {
		
		id = UUID.randomUUID();
		coordinateData = coordinates;
		building = newBuilding;
	}
	
	/**
	 * Returns the coordinate data.
	 * Will be in json format.
	 * 
	 * @return the coordinate data.
	 */
	public String getCoordinateData() {
		return coordinateData;
	}

	/**
	 * Sets the coordinate data.
	 * 
	 * @param coordinateData - the coordinates being set.
	 */
	public void setCoordinateData(String coordinateData) {
		this.coordinateData = coordinateData;
	}

	/**
	 * The id for the coordinate data.
	 * 
	 * @return the id of the coordinate data.
	 */
	public UUID getId() {
		return id;
	}

	/**
	 * Returns the building the data belongs to.
	 * 
	 * @return The building the data belongs to.
	 */
	public Building getBuilding() {
		return building;
	}
	
	

	
	
	
}
