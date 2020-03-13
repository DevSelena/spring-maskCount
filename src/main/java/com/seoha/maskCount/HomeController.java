package com.seoha.maskCount;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	@GetMapping("/2")
	public String test() {
		return "test";
	}
	
	
}
