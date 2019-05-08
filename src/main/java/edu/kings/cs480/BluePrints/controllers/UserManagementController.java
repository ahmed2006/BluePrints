package edu.kings.cs480.BluePrints.controllers;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import edu.kings.cs480.BluePrints.Adapters.SecurityAdapter;
import edu.kings.cs480.BluePrints.Adapters.UserAdapter;
import edu.kings.cs480.BluePrints.Database.AppUser;
import edu.kings.cs480.BluePrints.Database.UserRole;

/**
 * This class represents a controller which handles sending and receiving data
 * for the user management site.
 * 
 */
@Controller
@SessionAttributes("activeUser")
public class UserManagementController extends BluePrintsController {

	/** Used to handle calls to the blueprints database. */
	@Autowired
	private UserAdapter userAdapter;

	/**
	 * Returns a user with the corresponding king's id provided.
	 * 
	 * @param kingsId
	 *            - the king's id of the user being requested.
	 * @return A json with the provided user information.
	 */
	@ResponseBody
	@RequestMapping(value = "users/getUserInformation", method = RequestMethod.GET)
	public String getUserInformation(@RequestParam(name = "userId", required = true) UUID userId) {

		// TODO add actual database logic
		AppUser user = userAdapter.getUser(userId);
		JSONObject jsonObj = new JSONObject();

		if (user != null) {
			jsonObj.put("FirstName", user.getFirstName());
			jsonObj.put("LastName", user.getLastName());
			jsonObj.put("Email", user.getEmail());
			jsonObj.put("RoleID", user.getRole().getId());
			jsonObj.put("Role", user.getRole().getName());
		}

		return jsonObj.toString();

	}

	/**
	 * Updates the user which corresponds to the provided king's id, with the
	 * provided user information.
	 * 
	 * @param userId
	 *            - the id for the user being updated.
	 * @param roleId
	 *            - the new user role for the user.
	 * @return a message on whether, or not, the update was successful.
	 */
	@PostMapping(value = "users/updateUserInformation")
	public @ResponseBody String updateUserInformation(@RequestParam("userId") UUID userId,
			@RequestParam("userRole") UUID roleId) {
		// TODO when database stuff is figured out.
		JSONObject response = new JSONObject();

		boolean assigned = userAdapter.assignRole(userId, roleId);

		if (assigned) {
			response.put("msg", "ok");
		} else {
			response.put("msg", "Could not Update User.");
		}

		return response.toString();
	}

	/**
	 * Deletes the user which corresponds to the provided king's id, with the
	 * provided user information.
	 * 
	 * @param userId
	 *            - the id for the user being updated.
	 * @return a message on whether, or not, the update was successful.
	 */
	@PostMapping(value = "users/deleteUser")
	public @ResponseBody String deleteUser(@RequestParam("userId") UUID userId) {
		// TODO when database stuff is figured out.
		JSONObject response = new JSONObject();

		boolean deleted = userAdapter.deleteUser(userId);

		if (deleted) {
			response.put("msg", "ok");
		} else {
			response.put("msg", "Could not delete user.");
		}

		return response.toString();
	}

	/**
	 * Deletes the user which corresponds to the provided king's id, with the
	 * provided user information.
	 * 
	 * @param email
	 *            - the email of the user being added.
	 * @param roleId
	 *            - the new user role for the user.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return a message on whether, or not, the update was successful.
	 */
	@PostMapping(value = "users/addUser")
	public @ResponseBody String addUser(@RequestParam("firstName") String firstName,
			@RequestParam("lastName") String lastName, @RequestParam("email") String email,
			@RequestParam("userRole") UUID roleId, HttpSession session) {
		// TODO when database stuff is figured out.
		JSONObject response = new JSONObject();

		String msg = null;

		if (!userAdapter.doesUserExist(email)) {

			boolean added = userAdapter.createUser(firstName, lastName, email, roleId);

			if (added) {

				msg = "ok";
			} else {

				msg = "Could not add user.";
			}

		} else {
			msg = "This user already exists.";
		}

		response.put("msg", msg);

		return response.toString();
	}

	/**
	 * Handles the user management display page.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the page.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return the user management page, if there is an active user. The login page,
	 *         if not.
	 */
	@RequestMapping("users")
	public String displayUsers(Model model, HttpSession session) {

		String landPage = BluePrintsController.REDIRECT_LOGIN;

		if (loginAdapter.checkLogin(model, session)) {

			List<AppUser> users = userAdapter.getUsers();
			List<UserRole> roles = userAdapter.getUserRoles();

			model.addAttribute("users", users);
			model.addAttribute("roles", roles);

			landPage = "users";

		}

		return landPage;
	}

	/**
	 * Handles the password reset page.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the page.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return the password reset page, if there is an active user. The login page,
	 *         if not.
	 */
	@RequestMapping("passwordReset")
	public String displayPasswordReset(Model model, HttpSession session) {

		String landPage = "passwordReset";

		return landPage;
	}

	/**
	 * Deletes the user which corresponds to the provided king's id, with the
	 * provided user information.
	 * 
	 * @param email
	 *            - the email of the user being added.
	 * @param newPassword
	 *            - the password for the user.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return a message on whether, or not, the update was successful.
	 */
	@PostMapping(value = "users/changePassword")
	public @ResponseBody String changeUserPassword(@RequestParam("email") String email,
			@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword,
			HttpSession session) {
		JSONObject response = new JSONObject();

		String msg = null;

		AppUser user = userAdapter.getUserByEmail(email);

		System.out.println(user.getFirstName());
		try {
			if (user != null && SecurityAdapter.check(oldPassword, user.getPassword())) {

				boolean changed = userAdapter.changeUserPassword(newPassword, email);

				if (changed) {

					msg = "ok";
				} else {

					msg = "Error encountered when changing password.";
				}

			} else {
				msg = "Incorrect Email, or Password. Please check that your credentials are correct and try again.";
			}

		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
			msg = "Issue encountered when verifying user.";
		}

		response.put("msg", msg);

		return response.toString();
	}

}