/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * This interface is used to query entities from the building database.
 */
@Repository
public interface BuildingRepository extends JpaRepository<Building, UUID> {

}
