package edu.kings.cs480.BluePrints.controllers;


import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import edu.kings.cs480.BluePrints.Adapters.CommentAdapter;
import edu.kings.cs480.BluePrints.Adapters.FloorAdapter;
import edu.kings.cs480.BluePrints.Adapters.RoomAdapter;
import edu.kings.cs480.BluePrints.Database.Floor;
import edu.kings.cs480.BluePrints.Database.Room;
import edu.kings.cs480.BluePrints.Database.RoomCoordinates;
import edu.kings.cs480.BluePrints.Database.StaffAssignment;



/**
 * This class represents the controller which handles loading the floor map page
 * and interacting with its function calls.
 */
@RequestMapping("/mapManager/floor")
@Controller
public class FloorController extends BluePrintsController {
	
	/** Used to handle room data. */
	@Autowired
	private RoomAdapter roomAdapter;

    /** Used to handle floor data. */
    @Autowired
    private FloorAdapter floorAdapter;
    
    /** Used to handle comment data. */
    @Autowired
    private CommentAdapter commentAdapter;

    /**
     * This method is an end point call which creates a new room and returns 
     * whether, or not it was successful.
     * 
     * @param buildingId - the id of the building the floor is being added to.
     * @param floorName - the name of the floor being created.
     * @return whether, or not the room was created.
     * 
     */
    @RequestMapping("addFloor")
    @ResponseBody
    public String newFloor(@RequestParam(name = "buildingId", required = true) UUID buildingId, 
    @RequestParam(name = "floorName", required = true) String floorName) {

        System.out.println(buildingId);
        System.out.println(floorName);

        JSONObject response = new JSONObject();
        Floor newFloor = floorAdapter.addFloor(buildingId, floorName);
        
        if(newFloor != null) {
            response.put("status", "ok");
        } else {
            response.put("status", "Could not add floor.");
        }

        return response.toString();
    }

    /**
     * This method is an end point which deletes a floor from the system.
     * 
     * @param floorId - the id of the floor being deleted.
     * @return whether, or not, the floor was deleted.
     */
    @PostMapping("deleteFloor")
    @ResponseBody
    public String deleteFloor(@RequestParam(name = "floorId", required = true) UUID floorId) {
    	
    	 JSONObject response = new JSONObject();
    	 
    	commentAdapter.clearFloorComments(floorId);
    	 
    	if(roomAdapter.clearAllFloorRooms(floorId) && floorAdapter.deleteFloor(floorId)) {
            response.put("status", "ok");
        } else {
            response.put("status", "Could not delete floor.");
        }

        return response.toString();
    
    }
    
    /**
     * This method is an end point which duplicates a floor with the provided id.
     * 
     * @param originalFloorId - the id of the floor being duplicated.
     * @param newFloorName - the name of the new floor being created.
     * @return whether, or not, the floor was successfully duplicated.
     */
    @PostMapping("duplicateFloor")
    @ResponseBody
    public String duplicateFloor(@RequestParam(name = "floorId", required = true) UUID originalFloorId, 
    						  @RequestParam(name = "newFloorName", required = true) String newFloorName) {
    	
    	 JSONObject response = new JSONObject();
    	 
    	 Floor originalFloor = floorAdapter.getFloor(originalFloorId);
    	 
    	if(originalFloor != null) {
    		
    		Floor duplicateFloor = floorAdapter.addFloor(originalFloor.getBuilding().getId(), newFloorName);
    		
    		if(duplicateFloor != null) {
    			
    			List<Room> originalRooms = roomAdapter.getAllRooms(originalFloor.getId());
        		
        		for(Room room : originalRooms) {
        			
        			Room newRoom = roomAdapter.addRoom(room.getName(), duplicateFloor.getId());
        			
        			if(newRoom != null) {
        				RoomCoordinates coordinates = roomAdapter.getRoomCoordinates(room.getId());
        				roomAdapter.addRoomCoordinates(newRoom.getId(), coordinates.getCoordinateData());
        				List<StaffAssignment> roomAssignments = roomAdapter.getRoomAssignments(room.getId());
        				
        				UUID[] staffIds = new UUID[roomAssignments.size()];
        				int i = 0;
        				for(StaffAssignment assignment : roomAssignments) {
        					staffIds[i] = assignment.getStaffId();
        				}
        				
        				roomAdapter.assignStaffToRooms(newRoom.getId(), staffIds);
        				
        			}
        		}
        		
        		
        		response.put("status", "ok");
    		}
    		
    		
    		
    	} else {
    		
    		response.put("status", "Could not delete floor.");
    	}

        return response.toString();
    
    }
    
    
    
    
    /**
     * This method handles loading the floor editing page.
     * 
     * @param floorId - the id of the floor being edited.
     * @param model the model for the page. 
	 * @param session the session. 
	 * @return the name of the landing page.
     */
    @RequestMapping("floorEditor")
    public String floorEditor(@RequestParam(name = "floorId", required = true) UUID floorId, Model model, HttpSession session) {
        String landPage = "floorEditor";

        if(loginAdapter.checkLogin(model, session)) {
            Floor floor = floorAdapter.getFloor(floorId);

            if(floor != null) {

                model.addAttribute("floor", floor);
            } else {

                model.addAttribute("error", "Please Provide a floor ID.");
            }
        } else {
            landPage = BluePrintsController.REDIRECT_LOGIN;
        }

        return landPage;
    }
    
    
    
    
	
}
