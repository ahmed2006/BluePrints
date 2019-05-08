package edu.kings.cs480.BluePrints.controllers;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kings.cs480.BluePrints.Adapters.BuildingAdapter;
import edu.kings.cs480.BluePrints.Adapters.FloorAdapter;
import edu.kings.cs480.BluePrints.Database.Building;
import edu.kings.cs480.BluePrints.Database.BuildingCoordinate;
import edu.kings.cs480.BluePrints.Database.Floor;

import org.springframework.ui.Model;

/**
 * This class represents a controller responsible for handling the interactions
 * with the Map Manager Views.
 */
@Controller
@SessionAttributes("activeUser")
@RequestMapping("/mapManager")
public class BuildingController extends BluePrintsController {

	/**
	 * Used to handle any server side functionality for the map manager page.
	 */
	@Autowired
	private BuildingAdapter buildingAdapter;

	/**
	 * Used to handle any server side functionality dealing with floor data.
	 */
	@Autowired
	private FloorAdapter floorAdapter;

	/**
	 * Handles displaying information for the Map Manager section.
	 * 
	 * @param model the model for the page. 
	 * @param session the session. 
	 * @return the name of the landing page.
	 */
	@RequestMapping({ "", "/" })
	public String displayBuildings(Model model, HttpSession session) {

		String landPage = "mapManager";

		if (loginAdapter.checkLogin(model, session)) {
			List<Building> buildings = buildingAdapter.getBuildings();
			Map<String, List<Floor>> floors = floorAdapter.getFloors();

			if (buildings != null) {

				model.addAttribute("buildings", buildings);
				model.addAttribute("floors", floors);

			} else {

				model.addAttribute("status", "No buildings were found in the system.");
			}

		} else {
			landPage = BluePrintsController.REDIRECT_LOGIN;
		}

		return landPage;
	}
	
	/**
	 * Handles displaying the form for creating a new building.
	 * @param model the model for the page. 
	 * @param session the session. 
	 * @return the name of the landing page.
	 */
	@RequestMapping("/newBuilding")
	public String displayNewBuilding(Model model, HttpSession session) {

		String landPage = "newBuilding";

		if (!loginAdapter.checkLogin(model, session)) {

			landPage = BluePrintsController.REDIRECT_LOGIN;
			
		}
		
		model.addAttribute("source", "addBtn");

		return landPage;
	}
	
	

	/**
	 * Gets the building with the corresponding, provided, id and converts it
	 * into a JSON string to be returned.
	 * 
	 * @param buildingId
	 *            - the id of the building being requested.
	 * @return the information of the building in JSON format.
	 */
	@ResponseBody
	@RequestMapping("/getBuildingInfo")
	public String getBuildingInfo(@RequestParam(name = "buildingId", required = true) UUID buildingId) {

		JSONObject response = new JSONObject();
		Building building = buildingAdapter.getBuilding(buildingId);

		if (building != null) {
			response.put("buildingName", building.getName());
		} else {

			response.put("error", "This building could not be found.");
		}

		return response.toString();
	}

	/**
	 * Updates the building with the corresponding, provided, id and updates it
	 * with the provided information.
	 * 
	 * @param buildingId
	 *            - the id of the building being updated.
	 * @param buildingName
	 *            - the new name of the building being updated.
	 * @return the word "ok", if the building was successfully updated, or
	 *         failed if it wasn't.
	 */
	@ResponseBody
	@RequestMapping(value = "/updateBuilding", method = RequestMethod.POST)
	public String updateBuilding(@RequestParam(name = "buildingId", required = true) UUID buildingId,
			@RequestParam("buildingName") String buildingName, 
			@RequestParam(name = "coordinateData") String coordinateData) {

		JSONObject response = new JSONObject();

		boolean updated = buildingAdapter.updateBuilding(buildingId, buildingName);

		if (updated) {
			
			if(buildingAdapter.addCoordinates(buildingId, coordinateData)) {
				response.put("status", "ok");
			} else {
				response.put("status", "Could not update building coordinates");
			}
			
		} else {
			response.put("status", "Could not update building");
		}

		return response.toString();

	}
	
	@RequestMapping("/viewBuilding")
	public String viewBuilding(@RequestParam(name = "buildingId", required = true) UUID buildingId, Model model, HttpSession session) {
		
		String landPage = "newBuilding";

		if (!loginAdapter.checkLogin(model, session)) {
			
			landPage = BluePrintsController.REDIRECT_LOGIN;
			
		} else {
			Building building = buildingAdapter.getBuilding(buildingId);
			
			if(building != null) {
				model.addAttribute("building", building);
			} else {
				model.addAttribute("error", "Building Could not be found");
			}
		}
		
		model.addAttribute("source", "viewBtn");

		return landPage;
		
	}
	
	
	
	/**
	 * Removes the building with the corresponding, provided, id from the system.
	 * 
	 * @param buildingId - the id of the building being removed. 
	 * @return a JSON string containing the status on whether, or not, the being was deleted, or not.
	 */
	@ResponseBody
	@RequestMapping("/deleteBuilding")
	public String deleteBuilding(@RequestParam(name = "buildingId", required = true) UUID buildingId) {

		JSONObject response = new JSONObject();
		
		Building building = buildingAdapter.getBuilding(buildingId);
		
		if(building != null) {
			boolean deletedFloors = floorAdapter.deleteFloorsInBuilding(building);
			
			if(deletedFloors) {
				
				
				boolean deletedBuilding = buildingAdapter.deleteBuilding(buildingId);
				
				if(deletedBuilding) {
					
					response.put("status", "ok");
				
				} else {
					response.put("status", "Could not deleted Building.");
				}
				
			} else {
				response.put("status", "Could not delete floors.");
			}
			
		} else {
			response.put("status", "This building does not exist.");
		}
		
		

		return response.toString();

	}
	
	
	/**
	 * Takes a building name, and creator id and creates a new building, then stores
	 * it in the system.
	 * 
	 * @param buildingName - the new name of the building.
	 * @param creatorId - the id of the user creating the building.
	 * @return a status on whether, or not, the building was successfully created. In JSON format.
	 */
	@ResponseBody
	@RequestMapping(value = "/addBuilding", method = RequestMethod.POST)
	public String addBuidling(@RequestParam(name = "buildingName") String buildingName, @RequestParam(name = "creatorId") UUID creatorId,
			@RequestParam(name = "coordinateData") String coordinateData) {
		
		JSONObject response = new JSONObject();
		
		
		Building building = buildingAdapter.addBuilding(buildingName, creatorId);
		
		if(building != null) {
			
			if(buildingAdapter.addCoordinates(building.getId(), coordinateData)) {
				
				response.put("status", "ok");
				
			} else {
				response.put("status", "Could not add building coordinates");
			}
			
			
		} else {
			
			response.put("status", "Could not add building");
		}
		
		
		return response.toString();
	}
	
	
	/**
	 * Gets the building coordinates for the corresponding building id.
	 * 
	 * @param buildingId
	 *            - the id of the building the coordinates are being requested for.
	 * @return the coordinate data being requested.
	 */
	@ResponseBody
	@RequestMapping("/getBuildingCoordinates")
	public String getBuildingCoordinates(@RequestParam(name = "buildingId", required = true) UUID buildingId) {

		JSONObject response = new JSONObject();
		BuildingCoordinate coordinateData = buildingAdapter.getCoordinates(buildingId);

		if (coordinateData != null) {
			response.put("coordinateData", coordinateData.getCoordinateData());
		} else {

			response.put("error", "The requested coordinate data could not be found.");
		}

		return response.toString();
	}
	
	

}