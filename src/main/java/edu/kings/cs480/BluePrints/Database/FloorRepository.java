/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;
import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * This class represents a repository used to query data from the floor
 * table in the database.
 */
public interface FloorRepository extends JpaRepository<Floor, UUID> {
	
	List<Floor> findByBuilding(Building building);

}
