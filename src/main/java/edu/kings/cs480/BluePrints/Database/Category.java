package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="category")
public class Category {
	
	@Id
	@Column(name ="category_id")
	private UUID categoryID;
	
	@Column(name ="name")
	private String name;
	
	
	public Category(){
		categoryID = null;
		name = null;
	}
	
	public Category(String name){
		categoryID = UUID.randomUUID();
		this.name = name;
	}
	
	public UUID getCategoryID(){
		return categoryID;
	}
	
	public String getName(){
		return name;
	}
	
	public void setName(String name){
		this.name = name;
	}
}
