/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "room_coordinates")
public class RoomCoordinates {
	
	/** Keep track of the room's id.*/
	@Id
	@Column(name = "room_id")
	private UUID id;
	
	/** Keeps track of the name of the room.*/
	@Column(name = "room_coordinates", length = 4000)
	private String coordinateData;
	
	
	public RoomCoordinates() {
		id = null;
		coordinateData = null;
	}
	
	public RoomCoordinates(UUID roomId, String newCoordinateData) {
		
		id = roomId;
		coordinateData = newCoordinateData;
		
	}

	public UUID getId() {
		return id;
	}

	public String getCoordinateData() {
		return coordinateData;
	}

	public void setCoordinateData(String newCoordinateData) {
		coordinateData = newCoordinateData;
	}
	
	

}
