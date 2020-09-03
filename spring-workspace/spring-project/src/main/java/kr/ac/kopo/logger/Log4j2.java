package kr.ac.kopo.logger;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class Log4j2 {

	
	private static Logger LOGGER = LoggerFactory.getLogger(Log4j2.class);
	
	public void infoLog(String category, String message) {
		LOGGER.info("[ " + category + " ] " + message);
	}
	
}
