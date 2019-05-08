/**
 * 
 */
package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 * This class represents a entry for the app_user table in the BluePrints
 * database.
 *
 */
@Entity
@Table(name = "app_user")
public class AppUser {

	/** Keeps track of the primary key for the app user. */
	@Id
	@Column(name = "user_id")
	private UUID id;

	/** Keeps track of the app user's first name. */
	@Column(name = "first_name")
	private String firstName;

	/** Keeps track of the app user's last name. */
	@Column(name = "last_name")
	private String lastName;

	/** Keeps track of the app user's email address. */
	@Column(name = "email")
	private String email;
	
	/**Keeps track of the password for the user. */
	@Column(name = "password")
	private String password;

	/** Keeps track of the user assigned to the role. */
	@ManyToOne
	@JoinColumn(name = "role_id")
	private UserRole role;

	/**
	 * Creates a new user with the provided id number and email.
	 * 
	 * @param newFirstName
	 *            - the first name of the user being created.
	 * @param newLastName
	 *            - the last name of the user being created.
	 * @param newEmail
	 *            - the email for the new user being created.
	 */
	public AppUser(String newFirstName, String newLastName, String newEmail) {
		id = UUID.randomUUID();
		firstName = newFirstName;
		lastName = newLastName;
		email = newEmail;

	}

	/**
	 * Creates a new instance of AppUser and initializes it's fields.
	 */
	public AppUser() {
		id = null;
		firstName = null;
		lastName = null;
		email = null;
	}

	/**
	 * Return's the user's unique id.
	 * 
	 * @return the unique id for the user.
	 */
	public UUID getId() {
		return id;
	}

	/**
	 * Returns the first name of the user.
	 * 
	 * @return the first name of the user.
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Changes the first name of the user with the provided name.
	 * 
	 * @param firstName
	 *            - the new first name for the user.
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * Returns the last name of the user.
	 * 
	 * @return the last name of the user.
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Changes the last name of the user to the provided last name.
	 * 
	 * @param lastName
	 *            - the new last name for the user.
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * Returns the email for the user.
	 * 
	 * @return the email for the user.
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Changes the email for the user to the provided email.
	 * 
	 * @param email
	 *            - the new email for the user.
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Returns the role assigned to this user.
	 * 
	 * @return the role assigned to this user.
	 */
	public UserRole getRole() {
		return role;
	}

	/**
	 * Changes the role assigned to this user, to the 
	 * provided role.
	 * 
	 * @param role - the new role for the user.
	 */
	public void setRole(UserRole role) {
		this.role = role;
	}
	
	/**
	 * Returns the user's password.
	 * 
	 * @return the user's password.
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * Updates the password to the password provided.
	 * 
	 * @param newPassword
	 */
	public void setPassword(String newPassword) {
		password = newPassword;
	}
	
	

}
