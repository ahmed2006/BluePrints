/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * This interface represents a repository for the AppUser class. It can be used
 * to query data from the app_user table in the BluePrints database.
 *
 */
@Repository
public interface AppUserRepository extends JpaRepository<AppUser, UUID> {

	/**
	 * Returns a user with the matching email address.
	 * 
	 * @param email
	 *            - the email address being used to filter the AppUser table
	 *            data.
	 * @return the app user that has the provided email.
	 */
	AppUser findByEmail(String email);
	
	
	/**
	 * Return a set of users using the provided pageable  configuration.
	 * 
	 * @param pageConfig - the pageable configurations.
	 * @return the page data with the set of users.
	 */
	Page<AppUser> findAll(Pageable pageConfig);

}
