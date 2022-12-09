package egovframework.msa.sample.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RefreshScope
public class ConfigClientController {

	@Value("${config.profile}")
	private String profile;

	@Value("${config.message}")
	private String message;

	@GetMapping("/config/profile")
	public String profile() {
		return profile;
	}

	@GetMapping("/config/message")
	public String message() {
		return message;
	}

}