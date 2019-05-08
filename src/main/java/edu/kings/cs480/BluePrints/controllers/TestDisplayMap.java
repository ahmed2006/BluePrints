package edu.kings.cs480.BluePrints.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestDisplayMap {

	@RequestMapping("/testDisplayMap")
	public String index(){
		return "mapDisplay";
	}
}
