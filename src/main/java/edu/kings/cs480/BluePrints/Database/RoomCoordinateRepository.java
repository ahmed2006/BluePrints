package edu.kings.cs480.BluePrints.Database;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomCoordinateRepository extends JpaRepository<RoomCoordinates, UUID> {}
