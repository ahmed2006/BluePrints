/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * This class represents an entity for a user role in the
 * the user_role table in BluePrints database.
 */
@Entity
@Table(name = "user_role")
public class UserRole {

	/**Keeps track of the role's id. */
	@Id
	@Column(name = "role_id")
	private UUID id;
	
	/**Keeps track of the role's name.*/
	@Column
	private String name;
	
	/**Keeps track of permission level for the role. */
	@Column(name = "permission_level")
	private int permissionLevel;
	
	/**Keeps track of the users assigned to this role.*/
	//@OneToMany(mappedBy = "id", cascade = CascadeType.ALL)
	//private Set<AppUser> users;


	/**
	 * Creates a new user role and initializes its 
	 * values.
	 */
	protected UserRole() {
		id = null;
		name = null;
		permissionLevel = -1;
	}

	/**
	 * Returns the role's id.
	 * 
	 * @return the id
	 */
	public UUID getId() {
		return id;
	}
	
	

	/**
	 * Returns the role's name.
	 * 
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Returns the role's permissionLevel.
	 * 
	 * @return the permissionLevel
	 */
	public int getPermissionLevel() {
		return permissionLevel;
	}
	
	/**
	 * Returns the users assigned to this
	 * role.
	 * 
	 * @return the users assigned to this role.
	 */
//	public Set<AppUser> getUsers() {
//		return users;
//	}
	
	/**
	 * Changes the users assigned to this role.
	 * 
 	 * @param users - the new users assigned to this role.
	 */
//	public void setUsers(Set<AppUser> users) {
//		this.users = users;
//	}
	
	

}
