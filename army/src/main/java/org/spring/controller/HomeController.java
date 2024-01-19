package org.spring.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/*")
@AllArgsConstructor
public class HomeController {
	
	@GetMapping("/")
	public String mainpage() {
		return "index";
	}
	
	@GetMapping("/main2")
	public void mainpage2() {

	}

}
