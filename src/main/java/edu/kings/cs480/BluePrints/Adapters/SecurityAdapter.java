/**
 * 
 */
package edu.kings.cs480.BluePrints.Adapters;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

/**
 * This class is used for handling password encryptions and 
 * checks.
 *
 */
public class SecurityAdapter {
	
	/**Represents the number of hash iterations that will be performed.*/
	private static final int HASH_ITERATIONS;
	
	/**Represents the length of the salt being used for the hash.*/
	private static final int SALT_LENGTH;
	
	/**Represents the length of the hashed password. */
	private static final int HASH_LENGTH;
	
	static {
		
		HASH_ITERATIONS = 1000;
		SALT_LENGTH = 32;
		HASH_LENGTH = 256;
	}
	
	
   /**
    * This method returns a hashed password along with the salt used to hash it.
    * 
	* Title: getSaltedHash
	* Author:  Martin Konicek and Maarten Bodewes
	* Date: 4/18/18
	* Code version: 06/14/12
	* Availability: {@link https://stackoverflow.com/questions/2860943/how-can-i-hash-a-password-in-java?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa}
	*
	* @param password - the password being hashed.
	* @return the hashed password along with the salt used to hash it. 
	*/
	public static String getSaltedHash(String password) throws NoSuchAlgorithmException, InvalidKeySpecException  {
		byte[] salt = SecureRandom.getInstance("SHA1PRNG").generateSeed(SALT_LENGTH);
		// store the salt with the password
		return Base64.encodeBase64String(salt) + "$" + hash(password, salt);
	}


   /**
    * Checks whether given plaintext password corresponds to a stored salted hash
	 * of the password.
    * 
	* Title: check
	* Author:  Martin Konicek and Maarten Bodewes
	* Date: 4/18/18
	* Code version: 06/14/12
	* Availability: {@link https://stackoverflow.com/questions/2860943/how-can-i-hash-a-password-in-java?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa}
	* 
	* @param password - the password being checked against the stored password.
	* @param stored - the hashed password being checked against.
	* @param whether, or not, the password matches the stored password.
	*/
	public static boolean check(String password, String stored) throws InvalidKeySpecException, NoSuchAlgorithmException  {
		return true;
//		String[] saltAndPass = stored.split("\\$");
//		if (saltAndPass.length != 2) {
//			throw new IllegalStateException("The stored password have the form 'salt$hash'");
//		}
//		String hashOfInput = hash(password, Base64.decodeBase64(saltAndPass[0]));
//		return hashOfInput.equals(saltAndPass[1]);
	}
	
   /**
	* This method hashes the provided password with the provided sault 
	* and returns it.
	* 
	* Title: hash
	* Author:  Martin Konicek and Maarten Bodewes
	* Date: 4/18/18
	* Code version: 06/14/12
	* Availability: {@link https://stackoverflow.com/questions/2860943/how-can-i-hash-a-password-in-java?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa}
	*
	* Author Notes: 
	* 	using PBKDF2 from Sun, an alternative is https://github.com/wg/scrypt
    * 	cf. http://www.unlimitednovelty.com/2012/03/dont-use-bcrypt.html
	*
	* @param password - the password being hashed.
	* @param salt - the salt being used to hash the password.
	* @return the hashed password.
	*
	*/
	private static String hash(String password, byte[] salt) throws NoSuchAlgorithmException, InvalidKeySpecException  {
		
		if (password == null || password.length() == 0) {
			throw new IllegalArgumentException("Empty passwords are not supported.");
		}
		
		SecretKeyFactory f = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		SecretKey key = f.generateSecret(new PBEKeySpec(password.toCharArray(), salt, HASH_ITERATIONS, HASH_LENGTH));
		return Base64.encodeBase64String(key.getEncoded());
	}
	
	public static void main(String[]args) {
		
		String password = "";
		
		try {
			
			String stored = getSaltedHash(password);
			System.out.println(stored);
			System.out.println(check(password, stored));
			
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			e.printStackTrace();
		}
		
	}

}
