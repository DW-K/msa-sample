package egovframework.msa.sample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ConfigClientApplication {

	public static void main(String[] args) {

		String profile = System.getProperty("spring.profiles.active");
		if (profile == null) {
			System.setProperty("spring.profiles.active", "dev");
		}
		
		SpringApplication.run(ConfigClientApplication.class, args);
	}

}
