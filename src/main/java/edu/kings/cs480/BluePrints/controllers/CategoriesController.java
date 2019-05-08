package edu.kings.cs480.BluePrints.controllers;


import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kings.cs480.BluePrints.Database.Category;
import edu.kings.cs480.BluePrints.Database.CategoryRepository;

/**
 * This is a class for a Categories controller which extends the BluePrints Controller.
 */
@Controller
public class CategoriesController extends BluePrintsController {
	
	@Autowired
	CategoryRepository categoryRepo;
	
	/**
	 * Controller method for displaying the home categories page. 
	 * @param model the model for the page. 
	 * @param session the session. 
	 * @return the appropriate view. 
	 */
	@RequestMapping("/categories")
	public String displayCategories(Model model, HttpSession session){
		
		String landPage = BluePrintsController.REDIRECT_LOGIN;
		
		if(super.loginAdapter.checkLogin(model, session)){
			List<Category> categories  = categoryRepo.findAll();
			model.addAttribute("categories", categories);
			
			landPage = "categories";
		}
		return landPage;
	}
	
	
	
	@PostMapping(value = "/category/editCategory")
	@ResponseBody
	public String editCategory(@RequestParam("oldName") String oldName, @RequestParam("newName") String newName, @RequestParam("catId") UUID catId, HttpSession session){
		
		JSONObject response = new JSONObject();
		Category catToBeEdited = categoryRepo.findByCategoryID(catId);
		catToBeEdited.setName(newName);
		categoryRepo.save(catToBeEdited);
		response.put("msg", "ok");
		return response.toString();
	}
	
	@PostMapping(value = "/category/deleteCategory")
	@ResponseBody
	public String deleteCategory(@RequestParam("catId") UUID catId, HttpSession session){
		JSONObject response = new JSONObject();
		Category catToBeEdited = categoryRepo.findByCategoryID(catId);
		categoryRepo.delete(catToBeEdited);
		response.put("msg", "ok");
		return response.toString();
	}
	
	
	@PostMapping(value = "/category/addCategory")
	@ResponseBody
	public String addCategory(@RequestParam("name") String name, HttpSession session){
		JSONObject response = new JSONObject();
		Category newCategory = new Category(name);
		categoryRepo.save(newCategory);
		response.put("msg", "ok");
		return response.toString();
	}
}