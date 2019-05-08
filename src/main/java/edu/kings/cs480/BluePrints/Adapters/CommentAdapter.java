
package edu.kings.cs480.BluePrints.Adapters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kings.cs480.BluePrints.Database.Comment;
import edu.kings.cs480.BluePrints.Database.CommentRepository;
import edu.kings.cs480.BluePrints.Database.Floor;
import edu.kings.cs480.BluePrints.Database.FloorRepository;
import edu.kings.cs480.BluePrints.Database.AppUser;
import edu.kings.cs480.BluePrints.Database.AppUserRepository;

import java.util.UUID;
import java.util.ArrayList;
import java.util.List;

/**
 * This adapter is responsible for handling data involving comment.
 * 
 */
@Service
public class CommentAdapter {

	/** Handles calls to the Floor table in the database. */
	@Autowired
	public FloorRepository floorRepo;

	/** Handles calls to the App User table in the database. */
	@Autowired
	public AppUserRepository userRepo;

	/** Handles calls to the floor comment table in the database. */
	@Autowired
	public CommentRepository commentRepo;

	/**
	 * This method adds a comment to the floor.
	 * 
	 * @param floorId
	 *            - the id of the floor that comment is being added to.
	 * @param creatorId
	 *            - the id of the creator of this comment.
	 * @param commentMsg
	 *            - the comment being added to the floor.
	 * 
	 */
	public boolean addComment(UUID floorId, UUID creatorId, String commentMsg) {

		boolean added = false;

		AppUser user = userRepo.getOne(creatorId);
		Floor floor = floorRepo.getOne(floorId);

		if (floor != null && user != null) {

			Comment newComment = new Comment(floor, user, commentMsg);

			commentRepo.save(newComment);

			added = true;
		}

		return added;

	}

	/**
	 * This method updates a comment with the new message provided.
	 * 
	 * @param commentId
	 *            - the id of the comment being updated.
	 * @param editorId
	 *            - the id of the user updating this comment.
	 * @param newMsg
	 *            - the content of the new message for the comment.
	 */
	public boolean updateComment(UUID commentId, UUID editorId, String newMsg) {

		boolean updated = false;

		AppUser user = userRepo.findOne(editorId);
		Comment comment = commentRepo.findOne(commentId);

		if (comment != null && user != null) {

			comment.setCreator(user);
			comment.setMessage(newMsg);
			commentRepo.save(comment);

			updated = true;
		}

		return updated;

  }
  
  public boolean deleteComment(UUID deletorId, UUID commentId) {

    boolean deleted = false;

    AppUser user = userRepo.findOne(deletorId);
    Comment comment = commentRepo.findOne(commentId);

    if (comment != null && user != null) {
      comment.delete(user);
      commentRepo.save(comment);

      deleted = true;
    }
    return deleted;
  }

	/**
	 * This method returns the comments which corresponds to the floor id provided.
	 * 
	 * @param floorId
	 *            - the id of the floor the comment belong to.
	 * @return the comment for corresponding floor id.
	 */
	public List<Comment> getFloorComments(UUID floorId) {

    List<Comment> floorComments = null;
    List<Comment> existingComments = new ArrayList<Comment>();

    floorComments = commentRepo.findByFloorIdOrderByCreatedDateAsc(floorId);

    for (Comment comment : floorComments) {
      if (!comment.isDeleted()) {
        existingComments.add(comment);
      } 
    }

		return existingComments;
	}

	public void clearFloorComments(UUID floorId) {

		commentRepo.delete(this.getFloorComments(floorId));

	}

}