/**
 * 
 */
package edu.kings.cs480.BluePrints.Adapters;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kings.cs480.BluePrints.Database.AppUser;
import edu.kings.cs480.BluePrints.Database.AppUserRepository;
import edu.kings.cs480.BluePrints.Database.Building;
import edu.kings.cs480.BluePrints.Database.BuildingCoordinate;
import edu.kings.cs480.BluePrints.Database.BuildingRepository;
import edu.kings.cs480.BluePrints.Database.CoordinateRepository;

/**
 * This class is responsible for handling method used in the Map Manager Page.
 * 
 */
@Service
public class BuildingAdapter {

	/** Used to query data from the buildings table in the database. */
	@Autowired
	private BuildingRepository buildingRepo;

	/** Handles calls to the database about the users in the BluePrints System. */
	@Autowired
	private AppUserRepository userRepo;

	/** Handles calls to the database about the coordinate data for buildings. */
	@Autowired
	private CoordinateRepository coordinateRepo;

	/**
	 * Returns all the buildings stored in the system.
	 * 
	 * @return all the buildings stored in the system.
	 */
	public List<Building> getBuildings() {
		return buildingRepo.findAll();
	}

	/**
	 * Returns the building with the corresponding id provided.
	 * 
	 * @param buildingId
	 *            - the id of the building being returned.
	 * @return the building corresponding to the provided id.
	 */
	public Building getBuilding(UUID buildingId) {

		Building building = null;
		building = buildingRepo.findOne(buildingId);

		return building;
	}

	/**
	 * Updates the building with corresponding id, with the information provided.
	 * 
	 * @param buildingId
	 *            - the id of the building being updated.
	 * @param buildingName
	 *            - the new name of the building.
	 * @return whether, or not, the building was successfully updated.
	 */
	public boolean updateBuilding(UUID buildingId, String buildingName) {

		boolean updated = false;

		Building building = buildingRepo.findOne(buildingId);

		if (building != null) {

			building.setName(buildingName);
			buildingRepo.save(building);
			updated = true;
		}

		return updated;
	}

	/**
	 * Removes the building with the provided id from the system.
	 * 
	 * @param buildingId
	 *            - the id of the building being deleted.
	 * @return whether, or not, the building was successfully removed.
	 */
	public boolean deleteBuilding(UUID buildingId) {
		boolean deleted = false;
		Building building = getBuilding(buildingId);

		if (building != null) {
			buildingRepo.delete(building);
			deleted = true;
		}

		return deleted;

	}

	/**
	 * Adds a new building with the provided name, and creator id.
	 * 
	 * @param buildingName
	 *            - the name of the building.
	 * @param creatorId
	 *            - the id of the person creating the building.
	 * @return the newly added building.
	 */
	public Building addBuilding(String buildingName, UUID creatorId) {

		Building building = null;

		AppUser creator = userRepo.findOne(creatorId);

		if (creator != null) {
			building = new Building(buildingName, creator);
			buildingRepo.save(building);
		}

		return building;

	}

	/**
	 * Adds the coordinates to the database for the building with the corresponding
	 * building id.
	 * 
	 * @param buildingId
	 *            - the id of the building the coordinate belongs to.
	 * @param coordinateData
	 *            - the data being stored in the database.
	 * @return whether, or not, the data was successfully added.
	 */
	public boolean addCoordinates(UUID buildingId, String coordinateData) {

		boolean added = false;

		Building building = buildingRepo.findOne(buildingId);

		if (building != null) {
			BuildingCoordinate coordinates = new BuildingCoordinate(building, coordinateData);

			coordinateRepo.save(coordinates);
			added = true;
		}

		return added;
	}

	/**
	 * Updates the coordinate data for the building with the corresponding building
	 * id.
	 * 
	 * @param buildingId
	 *            - the id of the building the coordinate belongs to.
	 * @param coordinateData
	 *            - the data being stored in the database.
	 * @return whether, or not, the data was successfully updated.
	 */
	public boolean updateCoordinates(UUID buildingId, String coordinateData) {

		boolean updated = false;

		Building building = buildingRepo.findOne(buildingId);

		if (building != null) {
			BuildingCoordinate coordinates = coordinateRepo.findByBuilding(building);

			coordinates.setCoordinateData(coordinateData);
			coordinateRepo.save(coordinates);
			updated = true;
		}

		return updated;
	}

	/**
	 * Returns the coordinate data for the building with the corresponding building
	 * id.
	 * 
	 * @param buildingId
	 *            - the id of the building the coordinates are being requested for.
	 * @return the coordinates for the building.
	 */
	public BuildingCoordinate getCoordinates(UUID buildingId) {

		BuildingCoordinate coordinates = null;

		Building building = buildingRepo.findOne(buildingId);

		if (building != null) {
			coordinates = coordinateRepo.findByBuilding(building);
		}

		return coordinates;
	}

}
