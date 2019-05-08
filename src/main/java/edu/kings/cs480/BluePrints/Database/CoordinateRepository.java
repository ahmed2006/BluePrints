/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * This represents a repository that can be used to interact with 
 * the building_coordinate table in the database.
 */
public interface CoordinateRepository extends JpaRepository<BuildingCoordinate, UUID> {
	
	
	/**
	 * Returns the Coordinates for the corresponding building provided.
	 * 
	 * @return
	 */
	public BuildingCoordinate findByBuilding(Building building);
	
}
