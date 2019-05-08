/**
 * 
 */
package edu.kings.cs480.BluePrints.Adapters;


import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.naming.NamingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import edu.kings.cs480.BluePrints.Database.AppUser;

/**
 * This class represents a wrapper for an active directory connection, which
 * provides information about employees and students of King's College.
 */
@Service
public class LoginAdapter {
	
//	/** Used to log any errors that may error while using the active directory adapter. */
//	@Autowired
//	private LoggingAdapter loggingAdapter;

	@Autowired
	private UserAdapter userAdapter;


	/**
	 * Returns whether, or not, there is a user currently logged into the
	 * BluePrints system.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the
	 *            page currently being viewed by the user.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return whether, or not, there is a user currently logged in.
	 */
	public boolean checkLogin(Model model, HttpSession session) {

		boolean loggedIn = false;

		Object user = session.getAttribute("activeUser");

		if (user != null) {

			AppUser activeUser = (AppUser) user;

			loggedIn = true;
			model.addAttribute("activeUser", activeUser);

		}

		return loggedIn;
	}

	/**
	 * This helper method tries to log in with the provided password and user
	 * name and returns whether, or not, it was successful.
	 * 
	 * @param email
	 *            - the email of the user trying to log in.
	 * @param password
	 *            - the password of the user trying to log in.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return whether, or not, the user was able to login.
	 * @throws NamingException 
	 */
	public boolean login(String email, String password, HttpSession session) {

		boolean loggedIn = false;
		
		AppUser user = userAdapter.getUserByEmail(email);
		
		if(user != null) {
			
			String stored = user.getPassword();
			
			try {
				
				if(SecurityAdapter.check(password, stored)) {
					
					loggedIn = true;
					session.setAttribute("activeUser", user);
				}
			} catch (InvalidKeySpecException | NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			
		}
		

		return loggedIn;
	}
	
	
	/**
	 * Returns the active user in the provided session, if any.
	 * 
	 * @param session - the session containing the active user.
	 * @return the active user in the provided session, if any.
	 */
	public AppUser getActiveUser(HttpSession session) {
		AppUser activeUser = null;
		
		Object user = session.getAttribute("activeUser");

		if (user != null) {

			activeUser = (AppUser) user;
		}
		
		return activeUser;
	}
}