package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, UUID>{
	
	public Category findByCategoryID(UUID id);
	
	
}
