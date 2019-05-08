package edu.kings.cs480.BluePrints.ActiveDirectory;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchResult;
import javax.naming.directory.SearchControls;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

/**
 * AuthenticationService
 *
 * Provides an interface to authenticate against the King's Active Directory server.
 *
 */
public class AuthenticationService {

	// the domain name to authenticate against.
	private static String domain = "kings.edu";

	/**
	 * AuthenticationService()
	 */
	private AuthenticationService() {
	}

	/**
	 * authenticate
	 *
	 * Try to authenticate against active directory via ldap and return the status of the authentication.
	 *
	 * @param email The email to authenticate against.
	 * @param password The password associated with the email
	 * @return true if authentication was successful, otherwise false.
	 * @throws NamingException When communication or authentication fails against the domain controller.
	 */
	public static LdapContext authenticate(String email, String password) throws NamingException {

		// Define our properties of LDAP.
		Hashtable<String, String> adProps = new Hashtable<String, String>();
		adProps.put(Context.SECURITY_PRINCIPAL, email);
		adProps.put(Context.SECURITY_CREDENTIALS, password);
		adProps.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
		adProps.put(Context.PROVIDER_URL, "ldap://" + domain);

		// Try created a connection based on the above properties that we defined.
		try {
			return new InitialLdapContext(adProps, null);
		}
		catch(javax.naming.CommunicationException e) {
			e.printStackTrace();
			throw new NamingException("Failed to connect to " + domain);
		}
		catch(NamingException e) {
			throw new NamingException("Failed to authenticate against " + domain);
		}
	}

	/**
	 * getUser
	 *
	 * Returns the user object based on the user from AD, otherwise return null.
	 *
	 * @param email The email to retrieve.
	 * @param context The context connection to the AD directory.
	 * @return A user if the user exists, otherwise return null.
	 */
	public static AuthenticatedUser getUser(String email, LdapContext context) {
		
		
		try {
			
			String[] requestedAttrs = new String[] { "sn", "givenName", "KingsID", "mail", "userPrincipalName"};
			
			// Setup a search control.
			SearchControls controls = new SearchControls();
			// Limit our search, otherwise we will time out traversing the whole directory.
			controls.setSearchScope(javax.naming.directory.SearchControls.SUBTREE_SCOPE);
			// Limit our attributes, AD has 100+ fields, we don't need all of them.
			controls.setReturningAttributes(requestedAttrs);
			// Define our connection string, this format is required for LDAP.
			// TODO: Refactor this.
			NamingEnumeration<SearchResult> result = context.search("OU=User_New,DC=kings,DC=edu", "(& (userPrincipalName="+email+")(objectClass=user))", controls);
			// Search our attributes until we come across one that matches the email we specified.
			if (result.hasMore()) {
				Attributes attr = result.next().getAttributes();
				Attribute user = attr.get("userPrincipalName");
				if (user!=null) return new AuthenticatedUser(attr);
			}
		}
		catch(NamingException e) {
			// TODO: Handle this gracefully.
			//System.out.println(e.toString());
			e.printStackTrace();
		}

		return null;
	}
	
	
	
}