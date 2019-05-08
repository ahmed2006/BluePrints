
package edu.kings.cs480.BluePrints.Adapters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;


import edu.kings.cs480.BluePrints.Database.FloorRepository;
import edu.kings.cs480.BluePrints.Database.Floor;
import edu.kings.cs480.BluePrints.Database.Building;
import edu.kings.cs480.BluePrints.Database.BuildingRepository;


/**
 * This adapter is responsible for handling data involing 
 * floors. 
 */
@Service
public class FloorAdapter  {

    /** Used to handle calls to the database. */
    @Autowired
    private FloorRepository floorRepo;
    

    /** Used to query data from the buildings table in the database. */
	@Autowired
	private BuildingRepository buildingRepo;

    /**
     * This method takes a building id, and the name of a floor,
     * then adds it to the system. 
     * 
     * @param buildingId - the id of the building the floor is being added to.
     * @param floorName - the name of the floor being added to the building.
     * 
     */
    public Floor addFloor(UUID buildingId, String floorName) {

        Floor newFloor = null;

        Building building = buildingRepo.getOne(buildingId);

        if(building != null) {
            
            newFloor = new Floor(building, floorName);

            floorRepo.save(newFloor);

        }

        return newFloor;

    }

    
    
   
    public boolean deleteFloor(UUID floorId) {
    	
    	boolean deleted = false;
    	
    	
    	Floor floor = floorRepo.findOne(floorId);
    	
    	if(floor != null) {
    		
    		floorRepo.delete(floor);
    		deleted = true;
    	}
    	
    	return deleted;
  
    }
    
    public boolean deleteFloorsInBuilding(Building building) {
    	
    	boolean deleted = false;
     
    	
    	List<Floor> floors = floorRepo.findByBuilding(building);
    	
    	if(floors != null) {
    		for(Floor floor : floors) {
    			deleteFloor(floor.getId());
    		}
    		
    		deleted = true;
    	}
    	
    	return deleted;
    	
    }
    
    

    /**
     * Returns all the floors.
     * 
     */
    public Map<String, List<Floor>> getFloors() {

        HashMap<String, List<Floor>> buildingFloors = new HashMap<>();
        List<Floor> floors = floorRepo.findAll();

        for(Floor floor : floors) {

            Building building = floor.getBuilding();
            String buildingId = building.getId().toString();

            if(buildingFloors.containsKey(buildingId)) {
                buildingFloors.get(buildingId).add(floor);
                System.out.println(String.format("added Floor %s to list.", floor.getName()));
            } else {
                LinkedList<Floor> newFloorList = new LinkedList<>();
                newFloorList.add(floor);
                buildingFloors.put(buildingId, newFloorList);
                System.out.println(String.format("Created a new list for Building %s, and added Floor %s.", building.getName(), floor.getName()));
            }

        }

        return buildingFloors;

    }


    /**
     * This method returns the floor which corresponds 
     * to the id provided.
     * 
     * @param floorId - the id of the floor being requested.
     * @return the floor corresponding to the id provided.
     */
    public Floor getFloor(UUID floorId) {

        Floor floor = null;

        floor = floorRepo.getOne(floorId);

        return floor;
    }

}