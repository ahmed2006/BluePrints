package edu.kings.cs480.BluePrints.Adapters;

import java.util.logging.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class LoggingAdapter {
	
	private final static Logger LOGGER =  LogManager.getLogger();
	
	public void log(Level level, String message) {

		if(level == Level.INFO) {
			LOGGER.info(message);
		} else if(level == Level.WARNING) {
			LOGGER.warn(message);
		}

		
	}
	
}
