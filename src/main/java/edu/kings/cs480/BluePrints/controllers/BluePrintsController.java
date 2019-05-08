package edu.kings.cs480.BluePrints.controllers;

import org.springframework.beans.factory.annotation.Autowired;

import edu.kings.cs480.BluePrints.Adapters.LoginAdapter;
import edu.kings.cs480.BluePrints.Adapters.LoggingAdapter;

/**
 * This class represents the base controller for the BluePrints application.
 * 
 */
public class BluePrintsController {

	/** Represents the login redirect command for when the login check fails. */
	protected static final String REDIRECT_LOGIN;
	
	/** Represents the command to redirect to the home screen. */
	protected static final String REDIRECT_HOME;
	
	/** used to handle calls to the active directory for King's College.*/
	@Autowired
	protected LoginAdapter loginAdapter;

	/** used to log any errors that may occurs in the application.*/
	@Autowired
	protected LoggingAdapter logger;

	static {
		REDIRECT_LOGIN = "redirect:/login";
		REDIRECT_HOME = "redirect:/mapManager";
	}

	
}
