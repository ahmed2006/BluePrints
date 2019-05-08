package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;
import java.util.Calendar;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

/**
 * This class represents a entry for the comment table in the BluePrints
 * database.
 */
@Entity
@Table(name = "floor_comment")
public class Comment {

	/** Keeps track of the primary key for the comment table. */
	@Id
	@Column(name = "comment_id")
	private UUID id;

	/** Keeps track of the message content. */
	@Column(name = "comment_msg")
	private String commentMsg;

	/** Keeps track of the floor this comment belongs to. */
	@ManyToOne
	@JoinColumn(name = "floor_id")
    private Floor floor;
    
    /** Keeps track of the user this comment belongs to. */
	@NotFound(action = NotFoundAction.IGNORE)
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "created_by")
    private AppUser creator;
    
    /**Keeps track of the date this comment was created. */
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

  @Column(name = "deleted")
  @NotFound(action = NotFoundAction.IGNORE)
  private boolean deleted;

  @NotFound(action = NotFoundAction.IGNORE)
  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "deleted_by")
  private AppUser deletor;

  @Column(name = "deleted_date")
  private Date deletedDate;

	/**
	 * Creates a new floor comment with the provided id and message.
	 * 
     * @param floor - the floor this comment belongs to.
     * @param creator - the user that created this comment.
     * @param commentMsg - the content of the message being created.
	 */
	public Comment(Floor floor, AppUser creator, String commentMsg) {
        id = UUID.randomUUID();
        this.floor = floor;
        this.creator = creator;
        this.commentMsg = commentMsg;
        this.deleted = false;
                
        Calendar cal = Calendar.getInstance();
        createdDate = cal.getTime();
}

	/**
	 * Creates a new instance of Comment and initializes it's fields.
	 */
	public Comment() {
		id = null;
        floor = null;
        creator = null;
        commentMsg = null;
        
	}

	/**
	 * Return's the user's unique id.
	 * 
	 * @return the unique id for the user.
	 */
	public UUID getId() {
		return id;
	}
	

	/**
	 * This method returns the content of the comment.
	 * 
	 * @return the content of the message.
	 */
	public String getMessage() {
		return commentMsg;
    }
    
    /**
     * This method changes the content of the message 
     * to the new content provided.
     * 
     * @param newMsg - the new content of the comment.
     * 
     */
    public void setMessage(String newMsg) {
        commentMsg = newMsg;
    }

	/**
	 * This method returns floor this comment belongs to.
	 * 
	 * @return the floor this comment belongs to.
	 */
	public Floor getFloor() {
		return floor;
    }
    
    /**
     * This method returns the creator to this 
     * comment. 
     * 
     * @return the user which created this comment.
     */
    public AppUser getCreator() {
        return creator;
    }

    /**
     * Sets the new user to the provided user.
     * 
     * @param newUser - the new creator of the comment.
     */
    public void setCreator(AppUser newUser) {
        creator = newUser;
    }

    /**
     * Gets the date the comment was created.
     * 
     * @return the date the comment was created.
     * 
     */
    public Date getDate() {
        return createdDate;
    }
    

    /**
     * This method changes the created date
     * to the provided date.
     * 
     * @param newDate - the new date for this comment.
     * 
     */
    public void setDate(Date newDate) {
        createdDate = newDate;
    }

    public void setDeleted(boolean deleted) {
      if (deleted) {
        deleted = true;
      } else {
        deleted = false;
      }
    }

    public void delete(AppUser deletingUser) {
      Calendar cal = Calendar.getInstance();
      deleted = true;
      deletedDate = cal.getTime();
      deletor = deletingUser;
    }

    public boolean isDeleted() {
      return deleted;
    }

}