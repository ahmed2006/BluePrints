package edu.kings.cs480.BluePrints.controllers;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kings.cs480.BluePrints.Adapters.RoomAdapter;
import edu.kings.cs480.BluePrints.Adapters.StaffAdapter;
import edu.kings.cs480.BluePrints.Adapters.Mock.MockStaffAdapter;
import edu.kings.cs480.BluePrints.Database.Room;
import edu.kings.cs480.BluePrints.Database.RoomCoordinates;
import edu.kings.cs480.BluePrints.Database.Staff;
import edu.kings.cs480.BluePrints.Database.StaffAssignment;

@Controller
public class RoomController {

	@Autowired
	RoomAdapter roomAdapter;
	
	
	private StaffAdapter<UUID> staffAdapter;
	
	public RoomController() {
		staffAdapter = new MockStaffAdapter();
	}

	@RequestMapping("room/getRoom")
	@ResponseBody
	public String getRoom(@RequestParam(name = "roomId", required = true) UUID roomId) {

		JSONObject resp = new JSONObject();

		System.out.println(roomId);

		Room room = roomAdapter.getRoom(roomId);

		if (room != null) {

			RoomCoordinates coordinates = roomAdapter.getRoomCoordinates(roomId);

			if (coordinates != null) {

				resp.put("roomName", room.getName());
				resp.put("roomCoordinateData", coordinates.getCoordinateData());

			} else {

				resp.put("status", "Could not find room coordinate data");
			}

		} else {

			resp.put("status", "Could not find room");
		}

		return resp.toString();

	}

	@PostMapping("room/clearFloor")
	@ResponseBody
	public String clearFloor(@RequestParam(name = "floorId", required = true) UUID floorId) {

		JSONObject resp = new JSONObject();

		boolean cleared = roomAdapter.clearAllFloorRooms(floorId);

		if (cleared) {

			resp.put("status", "ok");
		} else {

			resp.put("status", "Encountered error when trying to clear the floor: ");
		}

		return resp.toString();

	}

	@PostMapping("room/deleteRoom")
	@ResponseBody
	public String deleteRoom(@RequestParam(name = "roomId", required = true) UUID roomId) {

		JSONObject resp = new JSONObject();

		boolean deleted = roomAdapter.deleteRoom(roomId);

		if (deleted) {

			resp.put("status", "ok");
		} else {

			resp.put("status", "Encountered error when trying to deleted the room with ID: " + roomId);
		}

		return resp.toString();

	}

	@PostMapping("room/updateRoom")
	@ResponseBody
	public String updateRoom(@RequestParam(name = "roomId", required = true) UUID roomId,
			@RequestParam(name = "roomName", required = true) String newRoomName,
			@RequestParam(name = "roomCoordinateData", required = true) String newRoomCoordinateData) {

		JSONObject resp = new JSONObject();

		boolean updatedRoom = roomAdapter.updateRoom(roomId, newRoomName);

		if (updatedRoom) {

			boolean updateRoomCoordinateData = roomAdapter.updateRoomCoordinates(roomId, newRoomCoordinateData);

			if (updateRoomCoordinateData) {

				resp.put("status", "ok");
			} else {

				resp.put("status", "Encountered error when updating room coordinate data.");
			}

		} else {

			resp.put("status", "Encountered error when updating room.");
		}

		return resp.toString();

	}

	@PostMapping("room/addRoom")
	@ResponseBody
	public String addRoom(@RequestParam(name = "floorId", required = true) UUID floorId,
			@RequestParam(name = "roomName", required = true) String newRoomName,
			@RequestParam(name = "roomCoordinateData", required = true) String roomCoordinateData) {

		JSONObject resp = new JSONObject();

		Room room = roomAdapter.addRoom(newRoomName, floorId);

		if (room != null) {

			boolean addedCoordinate = roomAdapter.addRoomCoordinates(room.getId(), roomCoordinateData);

			if (addedCoordinate) {

				resp.put("roomId", room.getId());

			} else {
				resp.put("status", "Could not add room coordinate data.");
			}

		} else {

			resp.put("status", "Could not add room.");
		}

		return resp.toString();

	}

	@RequestMapping("room/getRoomCoordinates")
	@ResponseBody
	public String getRoomCoordinates(@RequestParam(name = "floorId", required = true) UUID floorId) {

		JSONObject resp = new JSONObject();

		List<RoomCoordinates> roomCoordinates = roomAdapter.getAllRoomCoordinates(floorId);

		if (roomCoordinates != null) {

			resp.put("roomCoordinates", roomCoordinates);

		} else {

			resp.put("status", "Could not retrieve room coordinates");
		}

		return resp.toString();

	}

	@RequestMapping("room/getRooms")
	@ResponseBody
	public String getRooms(@RequestParam(name = "floorId", required = true) UUID floorId) {

		JSONObject resp = new JSONObject();

		List<Room> rooms = roomAdapter.getAllRooms(floorId);

		if (rooms != null) {

			List<JSONObject> roomJSONs = new LinkedList<>();

			for (Room room : rooms) {
				JSONObject roomJSON = new JSONObject();
				roomJSON.put("id", room.getId());
				roomJSON.put("name", room.getName());
				roomJSONs.add(roomJSON);
			}

			resp.put("rooms", roomJSONs);

		} else {

			resp.put("status", "Could not retrieve room");
		}

		return resp.toString();

	}

	@PostMapping("room/assignStaffToRoom")
	@ResponseBody
	public String assignStaffToRoom(@RequestParam(name = "roomId", required = true) UUID roomId,
			@RequestBody @RequestParam(name = "staffIds[]", required = true) UUID[] staffIds) {

		JSONObject resp = new JSONObject();
		boolean assigned = roomAdapter.assignStaffToRooms(roomId, staffIds);

		if (assigned) {

			resp.put("status", "ok");

		} else {
			resp.put("status", "Could not set staff.");
		}

		return resp.toString();

	}
	
	@RequestMapping("room/getRoomStaff")
	@ResponseBody
	public String getRoomStaff(@RequestParam(name = "roomId", required = true) UUID roomId) {

		JSONObject resp = new JSONObject();
		
		List<StaffAssignment> assignments = roomAdapter.getRoomAssignments(roomId);
		
		if (assignments != null) {
			
			List<JSONObject> staffJsonList = new LinkedList<>();

			for (StaffAssignment assignment : assignments) {
				
				Staff<UUID> staff = staffAdapter.getStaff(assignment.getStaffId());
				
				JSONObject staffJson = new JSONObject();
				staffJson.put("id", assignment.getStaffId());
				staffJson.put("name", staff.getName());
				staffJsonList.add(staffJson);
			}

			resp.put("staff", staffJsonList);

		} else {

			resp.put("status", "Could not retrieve staff");
		}


		return resp.toString();

	}
	
	@PostMapping("room/unassignStaff")
	@ResponseBody
	public String unassignStaff(@RequestParam(name = "roomId", required = true) UUID roomId,
								@RequestParam(name = "staffId", required = true) UUID staffId) {

		JSONObject resp = new JSONObject();
		
		boolean unassigned = roomAdapter.unassignStaff(staffId, roomId);
		
		if (unassigned) {
			resp.put("status", "ok");
		} else {

			resp.put("status", "Could not unassign staff");
		}


		return resp.toString();

	}
	
	@PostMapping("room/unassignAllStaff")
	@ResponseBody
	public String unassignAllStaff(@RequestParam(name = "roomId", required = true) UUID roomId) {

		JSONObject resp = new JSONObject();
		
		boolean unassigned = roomAdapter.unassignAllStaff(roomId);
		
		if (unassigned) {
			resp.put("status", "ok");
		} else {

			resp.put("status", "Could not unassign staff");
		}


		return resp.toString();

	}
	
	

}
