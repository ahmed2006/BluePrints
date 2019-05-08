package edu.kings.cs480.BluePrints.Adapters.Mock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import edu.kings.cs480.BluePrints.Adapters.StaffAdapter;
import edu.kings.cs480.BluePrints.Database.Staff;

public class MockStaffAdapter implements StaffAdapter<UUID> {

	
	private HashMap<UUID, Staff<UUID>> mockStaff;
	
	
	
	public MockStaffAdapter(){
		
		
		mockStaff = new HashMap<>();
		mockStaff.put(UUID.fromString("8761c1d6-df23-494c-a62e-5dd25bd7ee1a"), new MockStaff("Bob", UUID.fromString("8761c1d6-df23-494c-a62e-5dd25bd7ee1a"), "bob@kings.edu"));
		
		mockStaff.put(UUID.fromString("585b434e-4173-43d0-ae56-7d7b219f035f"), new MockStaff("Steven", UUID.fromString("585b434e-4173-43d0-ae56-7d7b219f035f"), "Steven@kings.edu"));
		
		mockStaff.put(UUID.fromString("2168ac0b-9da7-43e7-9b96-829f54cd87e1"), new MockStaff("Richard", UUID.fromString("2168ac0b-9da7-43e7-9b96-829f54cd87e1"), "Richard@kings.edu"));
		
		mockStaff.put(UUID.fromString("e15efdfe-bc09-40dc-9ea0-9fdad9b718b4"), new MockStaff("Chadd", UUID.fromString("e15efdfe-bc09-40dc-9ea0-9fdad9b718b4"), "Chadd@kings.edu"));
		
	}
	
	@Override
	public Staff<UUID> getStaff(UUID staffId) {
		
		
		return mockStaff.get(staffId);
		
	}

	@Override
	public void deleteStaff(UUID staffId) {
		
		throw new UnsupportedOperationException("Not needed for test");
	}
	
	
	@Override
	public List<Staff<UUID>> getAllStaff() {
		
		 return new ArrayList<>(mockStaff.values());
		 
	}

	@Override
	public void updateStaff(UUID staffId, String name, String email) {
		throw new UnsupportedOperationException("Not needed for test");
	}
	
	
	
	private class MockStaff implements Staff<UUID> {
		
		
		private String name;
		
		private UUID staffId;
		
		private String email;
		
		public MockStaff(String name, UUID staffId, String email) {
			this.name = name; 
			this.staffId = staffId;
			this.email = email;
		}
		
		@Override
		public String getName() {
			return name;
		}

		@Override
		public UUID getStaffId() {
			return staffId;
		}

		@Override
		public String getStaffEmail() {
			return email;
		}
		
	}



	
	
}
