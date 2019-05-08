package edu.kings.cs480.BluePrints.controllers;


import java.util.UUID;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import edu.kings.cs480.BluePrints.Adapters.CommentAdapter;
import edu.kings.cs480.BluePrints.Database.Comment;




/**
 * This class represents the controller which handles loading the floor map page
 * and interacting with its function calls.
 */
@RequestMapping("/mapManager/floor")
@Controller
public class CommentController extends BluePrintsController {

    /** Used to handle floor data. */
    @Autowired
    private CommentAdapter commentAdapter;
    


    /**
     * This method adds a comment to the floor with the corresponding floor 
     * id provided.
     * 
     * @param floorId - the id of the floor the comment is being added to.
     * @param creatorId - the id of the creator of the comment.
     * @param commentMsg - the content of the comment.
     * 
     */
    @RequestMapping(value = "addComment", method = RequestMethod.POST)
    @ResponseBody
    public String newFloor(@RequestParam(name = "floorId", required = true) UUID floorId, 
    @RequestParam(name = "creatorId", required = true) UUID creatorId, 
    @RequestParam(name = "commentMsg", required = true) String commentMsg) {

        JSONObject response = new JSONObject();

        boolean added = commentAdapter.addComment(floorId, creatorId, commentMsg);

        if(added) {
            response.put("status", "ok");
        } else {
            response.put("status", "could not add comment.");
        }

        return response.toString();
    }

    /**
     * This method updated the comment, with the provided id, with 
     * the provided message content.
     * 
     * 
     * @param commentId - the id of the comment being updated.
     * @param editorId - the id of the user that is updating this comment.
     * @param commentMsg - the content of the comment.
     */
    @RequestMapping(value = "updateComment", method = RequestMethod.POST)
    @ResponseBody
    public String updateComment(
      @RequestParam(name = "commentId", required = true) UUID commentId,
      @RequestParam(name = "creatorId", required = true) UUID editorId,  
      @RequestParam(name = "commentMsg", required = true) String commentMsg) {
                
        JSONObject response = new JSONObject();

        boolean updated = commentAdapter.updateComment(commentId, editorId, commentMsg);

        if(updated) {
            response.put("status", "ok");
        } else {
            response.put("status", "could not update the comment.");
        }

        return response.toString();
    }

    @RequestMapping(value = "deleteComment", method = RequestMethod.POST)
    @ResponseBody
    public String deleteComment(
      @RequestParam(name = "userId", required = true) UUID deletorId,
      @RequestParam(name = "commentId", required = true) UUID commentId) {

      JSONObject response = new JSONObject();

      boolean deleted = commentAdapter.deleteComment(deletorId, commentId);

      if (deleted) {
        response.put("status", "ok");
      } else {
        response.put("status", "could not delete the comment");
      }

      return response.toString();

    }


    /**
     * These method handles gettings comments and sending them to a page to be turned
     * into table rows for the comment section.
     * 
     * @param floorId - the id of the floor the comments belong to.s
     * @param model - the model of the page.
     */
    @RequestMapping(value = "getComments")
    public String getComments(@RequestParam(name = "floorId", required = true) UUID floorId, Model model) {

        String landPage = "getComments";


        List<Comment> floorComments = commentAdapter.getFloorComments(floorId);

        if(floorComments != null) {
            model.addAttribute("comments", floorComments);
        }

        return landPage;
    }
	
}
