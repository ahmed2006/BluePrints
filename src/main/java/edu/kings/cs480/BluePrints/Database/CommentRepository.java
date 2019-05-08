/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * This interface represents a repository for the AppUser class. It can be used
 * to query data from the app_user table in the BluePrints database.
 */
@Repository
public interface CommentRepository extends JpaRepository<Comment, UUID> {

	/**
	 * Returns the comment which have to the provided floor id.
	 * 
	 * @param floorId - the floor id being used to filter the comments.
	 * @return the comments that belong to the corresponding floor id.
	 */
	List<Comment> findByFloorIdOrderByCreatedDateAsc(UUID floorId);

}
