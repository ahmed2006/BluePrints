package edu.kings.cs480.BluePrints.controllers;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kings.cs480.BluePrints.Adapters.RoomAdapter;
import edu.kings.cs480.BluePrints.Adapters.StaffAdapter;
import edu.kings.cs480.BluePrints.Adapters.Mock.MockStaffAdapter;
import edu.kings.cs480.BluePrints.Database.Staff;
import edu.kings.cs480.BluePrints.Database.StaffAssignment;

@Controller
public class StaffController extends BluePrintsController {
	
	
	
	private StaffAdapter<UUID> staffAdapter;
	
	@Autowired
	private RoomAdapter roomAdapter;
	
	
	public StaffController() {
		staffAdapter = new MockStaffAdapter();
	}
	
	@RequestMapping("staff/getAllStaff")
	@ResponseBody
	public String getAllStaff(@RequestParam(name = "roomId") UUID roomId) {
		
		JSONObject resp = new JSONObject();
		
		List<Staff<UUID>>  staff = staffAdapter.getAllStaff();
		
		List<StaffAssignment> assignments = roomAdapter.getRoomAssignments(roomId);
		
		if(staff != null && assignments != null) {
			
			for(StaffAssignment assignment : assignments) {
				
				Staff<UUID> addedStaff = staffAdapter.getStaff(assignment.getStaffId());
				
				staff.remove(addedStaff);
				
			}
			
			List<JSONObject> staffJSONs = new LinkedList<>();
			
			for(Staff<UUID> current : staff) {
				
				System.out.println(current.getName());
				
				JSONObject staffJSON = new JSONObject();
				staffJSON.put("id", current.getStaffId());
				staffJSON.put("name", current.getName());
				staffJSON.put("email", current.getStaffEmail());
				staffJSONs.add(staffJSON);
			}
			
			resp.put("staff", staffJSONs);
		
		} else {
			
			resp.put("status", "Could not retrieve room");
		}
		
		return resp.toString();	
	}

	
	
}
