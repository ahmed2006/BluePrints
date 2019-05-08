package edu.kings.cs480.BluePrints.Database;

import java.io.Serializable;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "staff_assigned_to_room")
public class StaffAssignment implements Serializable{
	
	
	private static final long serialVersionUID = 2620119567850306216L;

	@Id
	@Column(name = "assignment_id")
	private UUID assignmentId;
	
	@ManyToOne
	@JoinColumn(name = "room_id")
	private Room room;
	
	@Column(name = "staff_id")
	private UUID staffId;
	
	public StaffAssignment() {
		assignmentId = null;
		room = null;
		staffId = null;
	}
	
	public StaffAssignment(Room newRoom, UUID newStaffId) {
		assignmentId = UUID.randomUUID();
		room = newRoom;
		staffId = newStaffId;
	}

	public UUID getId() {
		return assignmentId;
	}

	public Room getRoom() {
		return room;
	}

	public UUID getStaffId() {
		return staffId;
	}
	
	
	
	

}
