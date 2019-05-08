/**
 * 
 */
package edu.kings.cs480.BluePrints.ActiveDirectory;

import javax.naming.NamingException;
import javax.naming.directory.Attributes;

/**
 * This class represents a user from the Active Directory.
 */
public class AuthenticatedUser {

	/** Keeps track of the user's king's id. */
	private String kingsid;

	/** Keeps track of the user's first name. */
	private String firstName;

	/** Keeps track of the user's last name. */
	private String lastName;

	/** Keeps track of the user's email address. */
	private String email;

	/**
	 * Creates a user with the provided information.
	 * 
	 * @param attr
	 *            - the set of attributes which contains information about this
	 *            user.
	 *
	 */

	protected AuthenticatedUser(Attributes attr) throws NamingException {

		firstName = (String) attr.get("givenName").get(0);
		lastName = (String) attr.get("sn").get(0);
		kingsid = (String) attr.get("KingsID").get(0);
		email = (String) attr.get("mail").get(0);

	}

	/**
	 * Returns the user's first name.
	 * 
	 * @return the user's first name.
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * Returns the user's last name.
	 * 
	 * @return the user's last name.
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * Returns the user's email.
	 * 
	 * @return the user's email.
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * Returns the user's king's id.
	 * 
	 * @return the user's king's id.
	 */
	public String getKingsId() {
		return kingsid;
	}

}
