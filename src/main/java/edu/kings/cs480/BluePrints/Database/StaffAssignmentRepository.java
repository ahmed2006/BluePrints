package edu.kings.cs480.BluePrints.Database;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

public interface StaffAssignmentRepository extends JpaRepository<StaffAssignment, UUID>{
	
	
	public List<StaffAssignment> findByRoom(Room room);
	
	public StaffAssignment findByStaffIdAndRoom(@Param("staff_id") UUID staffId, @Param("room_id") Room room);
	
	
}
