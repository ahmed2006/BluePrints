package edu.kings.cs480.BluePrints.Adapters;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kings.cs480.BluePrints.Database.Floor;
import edu.kings.cs480.BluePrints.Database.Room;
import edu.kings.cs480.BluePrints.Database.RoomCoordinateRepository;
import edu.kings.cs480.BluePrints.Database.RoomCoordinates;
import edu.kings.cs480.BluePrints.Database.RoomRepository;
import edu.kings.cs480.BluePrints.Database.StaffAssignment;
import edu.kings.cs480.BluePrints.Database.StaffAssignmentRepository;

@Service
public class RoomAdapter {

	@Autowired
	private RoomRepository roomRepo;

	@Autowired
	private RoomCoordinateRepository roomCoordinateRepo;

	@Autowired
	private FloorAdapter floorAdapter;
	
	@Autowired
	private StaffAssignmentRepository staffRepo;

	public Room getRoom(UUID roomId) {

		Room room = roomRepo.findOne(roomId);

		return room;

	}

	public List<Room> getAllRooms(UUID floorId) {

		List<Room> rooms = null;

		Floor floor = floorAdapter.getFloor(floorId);

		if (floor != null) {

			rooms = roomRepo.findByFloor(floor);

		}

		return rooms;
	}

	public Room addRoom(String roomName, UUID floorId) {

		Room room = null;

		Floor floor = floorAdapter.getFloor(floorId);

		if (floor != null) {

			room = new Room(roomName, floor);

			roomRepo.save(room);

		}

		return room;

	}

	public boolean updateRoom(UUID roomId, String newRoomName) {

		boolean updated = false;

		Room room = roomRepo.findOne(roomId);

		if (room != null) {

			room.setName(newRoomName);
			roomRepo.save(room);

			updated = true;
		}

		return updated;
	}

	public boolean deleteRoom(UUID roomId) {

		boolean deleted = false;

		Room room = roomRepo.findOne(roomId);

		if (room != null) {
			
			unassignAllStaff(roomId);
			roomCoordinateRepo.delete(roomId);
			roomRepo.delete(room);
			deleted = true;
		}

		return deleted;

	}

	public boolean addRoomCoordinates(UUID roomId, String roomCoordinateData) {

		boolean added = false;

		if (roomRepo.exists(roomId)) {

			RoomCoordinates roomCoordinates = new RoomCoordinates(roomId, roomCoordinateData);
			roomCoordinateRepo.save(roomCoordinates);
			added = true;
		}

		return added;

	}

	public boolean deleteRoomCoordinates(UUID roomId) {

		boolean deleted = false;

		RoomCoordinates coordinates = roomCoordinateRepo.findOne(roomId);

		if (coordinates != null) {

			roomCoordinateRepo.delete(coordinates);
			deleted = false;

		}

		return deleted;

	}

	public boolean updateRoomCoordinates(UUID roomId, String newRoomCoordinateData) {

		boolean updated = false;

		RoomCoordinates coordinates = roomCoordinateRepo.findOne(roomId);

		if (coordinates != null) {

			coordinates.setCoordinateData(newRoomCoordinateData);
			roomCoordinateRepo.save(coordinates);
			updated = true;
		}

		return updated;

	}

	public List<RoomCoordinates> getAllRoomCoordinates(UUID floorId) {

		List<RoomCoordinates> roomCoordinates = null;

		Floor floor = floorAdapter.getFloor(floorId);

		if (floor != null) {

			List<Room> rooms = roomRepo.findByFloor(floor);

			if (rooms != null) {

				roomCoordinates = new LinkedList<>();

				for (Room room : rooms) {

					RoomCoordinates coordinates = roomCoordinateRepo.findOne(room.getId());
					roomCoordinates.add(coordinates);
				}

			}

		}

		return roomCoordinates;
	}

	public RoomCoordinates getRoomCoordinates(UUID roomId) {

		RoomCoordinates coordinates = roomCoordinateRepo.findOne(roomId);

		return coordinates;

	}

	public boolean clearAllFloorRooms(UUID floorId) {

		boolean deleted = false;

		Floor floor = floorAdapter.getFloor(floorId);

		if (floor != null) {

			List<Room> rooms = roomRepo.findByFloor(floor);

			for (Room room : rooms) {

				deleteRoom(room.getId());
			}

			deleted = true;
		}
		return deleted;
	}
	
	public List<StaffAssignment> getRoomAssignments(UUID roomId){
		
		List<StaffAssignment> result = null;;
		
		Room room = roomRepo.findOne(roomId);
		
		if(room != null) {
			result =  staffRepo.findByRoom(room);
		}
		
		return result;
		
	}
	
	public boolean assignStaffToRooms(UUID roomId, UUID[] staffIds) {
		
		boolean assigned = false;
		
		Room room = roomRepo.findOne(roomId);
		
		if(room != null) {
			
			for(UUID staffId : staffIds) {
				
				StaffAssignment assignment = new StaffAssignment(room, staffId);
				
				staffRepo.save(assignment);
			}
			
			assigned = true;
		}
		
		
		return assigned;
		
	}
	
	public boolean unassignStaff(UUID staffId, UUID roomId) {
		
		boolean unassigned = false;
		
		Room room = getRoom(roomId);
		
		if(room != null) {
			
			StaffAssignment assignmentId = staffRepo.findByStaffIdAndRoom(staffId, room);
			
			if(assignmentId != null) {
				
				staffRepo.delete(assignmentId);
				unassigned = true;
			}
		}
		
		return unassigned;
		
	}
	
	public boolean unassignAllStaff(UUID roomId) {

		boolean unassigned = false;

		Room room = getRoom(roomId);

		if (room != null) {

			List<StaffAssignment> assignments = staffRepo.findByRoom(room);

			if (assignments != null) {
				
				for(StaffAssignment assignment : assignments) {
					
					staffRepo.delete(assignment);
				}

				unassigned = true;
			}
		}

		return unassigned;

	}
	
	
}
