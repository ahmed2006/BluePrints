/**
 * 
 */
package edu.kings.cs480.BluePrints.controllers;

import java.util.logging.Level;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * This class represents the main controller for the BluePrints site.
 */
@Controller
@SessionAttributes("activeUser")
public class LoginController extends BluePrintsController {
	/**
	 * Handles setting up the home page.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the page.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * 
	 * @return the home page, if there is an active user. The login page, if not.
	 */
	@RequestMapping(value = "")
	public String index(Model model, HttpSession session) {

		String landPage = BluePrintsController.REDIRECT_LOGIN;

		if (super.loginAdapter.checkLogin(model, session)) {

			landPage = "index";
		}

		return landPage;

	}

	/**
	 * Handles displaying the login page.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the page.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return The login page.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String displayLogin(Model model, HttpSession session) {

		String landPage = "login";

		if (loginAdapter.checkLogin(model, session)) {

			landPage = BluePrintsController.REDIRECT_LOGIN;
		}

		return landPage;
	}

	/**
	 * Handles processing the credentials submitted by the login page.
	 * 
	 * @param email
	 *            - the provided email by the login page.
	 * @param password
	 *            - the provided password by the login page.
	 * @param model
	 *            - the model used to store attributes that can be used in the page.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return the home page, if the login was successful. The login page with an
	 *         error, if not.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String submitLogin(@RequestParam(name = "email", required = true) String email,
			@RequestParam(name = "password", required = true) String password, Model model, HttpSession session) {

		String landPage = "login";
		String userEmail = email.trim();

		if (loginAdapter.login(userEmail, password, session)) {

			landPage = BluePrintsController.REDIRECT_HOME;
			logger.log(Level.INFO, "Logged in Successful");
		} else {
			model.addAttribute("error", "Please check your email and password, then try again.");
			model.addAttribute("email", userEmail);
		}

		return landPage;
	}

	/**
	 * Logs the user out of the system, and returns the user to the login page.
	 * 
	 * @param model
	 *            - the model used to store attributes that can be used in the page
	 *            currently being viewed by the user.
	 * @param session
	 *            - the session which keeps track of the currently active user.
	 * @return the redirect command to the login page.
	 */
	@RequestMapping("/logout")
	public String logout(Model model, HttpSession session) {

		session.invalidate();
		model.asMap().remove("activeUser");

		return BluePrintsController.REDIRECT_LOGIN;
	}

}