/**
 * 
 */
package edu.kings.cs480.BluePrints.Adapters;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kings.cs480.BluePrints.Database.AppUser;
import edu.kings.cs480.BluePrints.Database.AppUserRepository;
import edu.kings.cs480.BluePrints.Database.UserRole;
import edu.kings.cs480.BluePrints.Database.UserRoleRepository;

/**
 * This represents an Adapter handling data 
 * about the users in the database.
 *
 */
@Service
public class UserAdapter {
	
	/**Handles the database calls dealing with users. */
	@Autowired
	private AppUserRepository userRepo;
	
	/**Handles the database calls dealing with user roles. */
	@Autowired
	private UserRoleRepository roleRepo;
	
	/**
	 * Returns the available user roles. 
	 * 
	 * @return the user roles. 
	 */
	public List<UserRole> getUserRoles() {
		return roleRepo.findAll();
	}
	
	/**
	 * Returns the user with the provided id.
	 * 
	 * @param userId - the id of the user being requested.
	 * @return the user with the provided id.
	 */
	public AppUser getUser(UUID userId) {
		return userRepo.findOne(userId);
	}
	
	/**
	 * Returns the users with the provided email.
	 * 
	 * @param email - the email of the user being requested.
	 * @return the user with the provided email.
	 */
	public AppUser getUserByEmail(String email) {
		return userRepo.findByEmail(email);
	}

	/**
	 * Get the user role with the provided id.
	 * 
	 * @param id - the id of the user role being requested.
	 * @return the user role being requested.
	 */
	public UserRole getUserRole(UUID id) {
		return roleRepo.findOne(id);
	}


	/**
	 * Assigns the user role corresponding to the provided user role id
	 * with the user that corresponds to the user with the provided user id.
	 * 
	 * @param userId - the id of the user being assigned the role.
	 * @param roleID - the id of the user role being assigned to the user.
	 * @return whether, or not, the assignment was successful.
	 */
	public boolean  assignRole(UUID userId, UUID roleID) {
		
		boolean assigned = false;
		
		UserRole role = getUserRole(roleID);
		
		
		if(role != null) {
			
			AppUser user = getUser(userId);
			
			if(user != null) {
				
				user.setRole(role);
				userRepo.save(user);
				assigned = true;
			}
		}
		
		return assigned;
		
	}

	/**
	 * Deletes a user with the provided id.
	 * 
	 * @param userId - the id of the user being deleted.
	 * @return whether, or not, the user was successfully deleted.
	 */
	public boolean deleteUser(UUID userId) {
		
		boolean deleted = false;
		
		AppUser user = getUser(userId);
		
		if(user != null) {
			
			userRepo.delete(user);
			
			deleted = true; 
		}
		
		
		return deleted;
	}
	
	public boolean createUser(String firstName, String lastName, String email, UUID roleId) {
	
		boolean created = false;
		
		UserRole role = roleRepo.findOne(roleId);
		
		if(role != null) {
			
			AppUser newUser = new AppUser(firstName, lastName, email);
			newUser.setRole(role);
			try {
				newUser.setPassword(SecurityAdapter.getSaltedHash("Kings"));
				userRepo.save(newUser);
				
				created = true;
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (InvalidKeySpecException e) {
				e.printStackTrace();
			}
			
		}
		
		return created;
	}
	
	public List<AppUser> getUsers() {
		return userRepo.findAll();
	}
	
	public boolean doesUserExist(String email) {
		
		boolean exists = false;
		
		AppUser user = userRepo.findByEmail(email);
		
		if(user != null) {
			exists = true;
		}
		
		return exists;
	}
	
	
	public boolean changeUserPassword(String newPassword, String email) {
		 
		boolean passwordChanged = false;
		
		
		AppUser user = userRepo.findByEmail(email);
		
		
		if(user != null) {
			
			String hashedPassword;
			
			try {
				
				hashedPassword = SecurityAdapter.getSaltedHash(newPassword);
				user.setPassword(hashedPassword);
			
				userRepo.save(user);
				passwordChanged = true;
				
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (InvalidKeySpecException e) {
				e.printStackTrace();
			}
			
		}
		
		return passwordChanged;
	}
	

}
