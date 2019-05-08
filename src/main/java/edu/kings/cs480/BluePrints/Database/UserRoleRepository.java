/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * This class represents a repository used to query data from the user role
 * table in the database.
*/
@Repository
public interface UserRoleRepository extends JpaRepository<UserRole, UUID> {

}
