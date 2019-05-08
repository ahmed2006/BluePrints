/**
 * 
 */
package edu.kings.cs480.BluePrints;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * This class represents the main launcher for the BluePrints application.
 */
@EnableJpaRepositories
@SpringBootApplication
public class BluePrintsMain extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
    return application.sources(BluePrintsMain.class);
  }

	/**
	 * Starts the BluePrints application.
	 * 
	 * @param args
	 *            - the commands provided by the user.
	 */
	public static void main(String[] args) {
		SpringApplication.run(BluePrintsMain.class, args);
		//testing
		
	}

}
