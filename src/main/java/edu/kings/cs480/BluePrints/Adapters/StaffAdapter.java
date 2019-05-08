package edu.kings.cs480.BluePrints.Adapters;

import java.util.List;

import edu.kings.cs480.BluePrints.Database.Staff;

public interface StaffAdapter<T> {
	
	
	public Staff<T> getStaff(T staffId);
	
	public void deleteStaff(T staffId);
	
	public List<Staff<T>> getAllStaff();
	
	public void updateStaff(T staffId, String name, String email);
}
