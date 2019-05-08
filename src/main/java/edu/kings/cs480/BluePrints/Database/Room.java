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

@Entity
@Table(name = "room")
public class Room {
	
	/** Keep track of the room's id.*/
	@Id
	@Column(name = "room_id")
	private UUID id;
	
	/** Keeps track of the name of the room.*/
	@Column(name = "room_name")
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "floor_id")
	private Floor floor;
	
	
	public Room() {
		id = null;
		name = null;
		floor = null;
	}
	
	public Room(String newName, Floor newFloor) {
		
		id = UUID.randomUUID();
		name = newName;
		floor = newFloor;
		
	}

	public UUID getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Floor getFloor() {
		return floor;
	}

	public void setFloor(Floor floor) {
		this.floor = floor;
	}
	
	

}
