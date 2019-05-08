function rehydrateRooms(coordinates) {

  var roomCoordinteData = coordinates.coordinateData;
  var roomFeature = convertJSONtoFeature(roomCoordinteData);
  roomFeature.set("roomId", coordinates.id);
  floorLayer.getSource().addFeature(roomFeature);

}

function getRoomCoordinates(floorId) {

  $.ajax({
    url: "/BluePrints/room/getRoomCoordinates",
    type: "GET",
    dataType: "json",
    data: {floorId: floorId},
    success: function(response) {

        var roomCoordinates = response["roomCoordinates"];

        if(typeof roomCoordinates == 'undefined') {

          var status = response["status"];
          console.log(status);

        } else {

          roomCoordinates.forEach(rehydrateRooms);
        }
    },
    error: printError
  });

}

function addRoom(floorId, roomName, roomCoordinateData, resultsFunction) {


    $.ajax({
      url: "/BluePrints/room/addRoom",
      type: "POST",
      dataType: "JSON",
      data: {
        floorId : floorId,
        roomName : roomName,
        roomCoordinateData : roomCoordinateData
      },
      success: function(resp) {
        var roomId = resp["roomId"];

        if(typeof roomId != 'undefined') {

          resultsFunction(roomId);
        } else {

          resultsFunction(null);
        }

        console.log(resp);
      },
      error: printError
    });
}


function getRoom(roomId, resultsFunction) {

  $.ajax({
    url: "/BluePrints/room/getRoom",
    type: "GET",
    dataType: "json",
    data: {roomId: roomId},
    success: function(response) {

      var roomName = response["roomName"];
      var roomCoordinateData = response["roomCoordinateData"];


      if(typeof roomName != "undefined" && typeof roomCoordinateData != "undefined") {

          var room = {
            name: roomName,
            coordinates: roomCoordinateData
          };

          resultsFunction(room);
      } else {
        var status = response["status"];
        console.log(status);

      }
    },
    error: printError
  });

}

function updateRoom(floorId, roomId, roomName, roomCoordinateData) {
  $.ajax({
    url: "/BluePrints/room/updateRoom",
    type: "POST",
    dataType: "json",
    data: {
      roomId: roomId,
      roomName: roomName,
      roomCoordinateData: roomCoordinateData
    },
    success: function(response) {
      var status = response["status"];

      if(status == "ok") {
        updateRoomTable(floorId);
      }
    },
    error: printError
  });
}

function deleteRoom(roomId, floorId, roomFeature) {
  $.ajax({
    url: "/BluePrints/room/deleteRoom",
    type: "POST",
    dataType: "json",
    data: {
      roomId: roomId
    },
    success: function(response) {
      var status = response["status"];

      if(status == "ok") {
        floorLayer.getSource().removeFeature(roomFeature);
        deselectRoom();
        updateRoomTable(floorId);
      }
    },
    error: printError
  });
}



function selectRoom(roomId) {

  $(".roomPanel").removeAttr("hidden");
  $(".floorPanel").attr("hidden", "");

  getRoom(roomId, function(room) {

    $("#roomName").val(room.name);
    $("#roomId").val(roomId);
    $("#roomNameBreadCrumb").html(room.name);
  	$(".deleteRoomName").html(room.name);
    getRoomFromLayer(roomId, floorLayer, function(roomFeature){
        floorTransform.setActive(true);
        floorTransform.select(roomFeature);
        floorSelector.getFeatures().clear();
        floorSelector.getFeatures().push(roomFeature);
        console.log(roomFeature.getStyle());
        roomFeature.getStyle().setZIndex(99);
    });
    updateRoomStaff(roomId);
  });

}

function deselectRoom() {

  floorSelector.getFeatures().forEach(function(roomFeature) {
      roomFeature.getStyle().setZIndex(0);
  });

  floorSelector.getFeatures().clear();
  floorTransform.setActive(false);
  $(".floorPanel").removeAttr("hidden");
  $(".roomPanel").attr("hidden", "");
}

function resetFloorInteractions() {
  map.getInteractions().clear();

  var defaultInteractions = ol.interaction.defaults();

  defaultInteractions.forEach(function(interaction) {
    map.addInteraction(interaction);
  });

  map.addInteraction(floorTransform);

  map.addInteraction(floorSelector);
}


function promptDuplicate(roomId, floorId) {
  $("#duplicateModal").modal("show");
  $("#duplicateName").val("");
  $("#duplicateRoomBtn").attr("roomId", roomId);
  $("#duplicateRoomBtn").attr("floorId", floorId);
}

function promoteDelete(roomId) {
    selectRoom(roomId);
    $("#confirmDeleteRoom1").modal("show");
}


function updateRoomTable(floorId) {

  $.ajax({
    url: "/BluePrints/room/getRooms",
    type: "GET",
    dataType: "json",
    data: {floorId: floorId},
    success: function(response) {
      var rooms = response["rooms"];

      if(typeof rooms != 'undefined') {

          var roomData = "";

          if(rooms.length > 0) {

            for(var i = 0; i < rooms.length; i++) {
                var roomRowTop = "<tr>";
                var roomRowNameData =  "<td width='40%'>" + rooms[i].name + "</td>";
                var roomViewBtn = "<button class='btn btn-info btn-sm' onclick='selectRoomRow(\"" + rooms[i].id + "\");'><i class='fas fa-eye'></i> View</button>&nbsp;";
                var roomDuplicateBtn = "<button class='btn btn-info btn-sm' onclick='promptDuplicate(\"" + rooms[i].id + "\", \"" + floorId + "\");'><i class='far fa-copy'></i> Duplicate</button>&nbsp;";
                var roomDeleteBtn = "<button class='btn btn-danger btn-sm' onclick='promoteDelete(\"" + rooms[i].id + "\");'><i class='fas fa-trash'></i> Delete</button>";
                var roomRowActionButtons = "<td width='60%'><div class='col-sm-6' style='display: flex;'>" + roomViewBtn + roomDuplicateBtn + roomDeleteBtn + "</div></td>";
                var roomRowBottom = "</tr>";
                var roomRow = roomRowTop + roomRowNameData + roomRowActionButtons + roomRowBottom ;
                roomData += roomRow;
            }
          } else {

            roomData = "<tr><td align='center'><b>No Rooms</b></td></tr>";
          }

          $("#roomSection").html(roomData);
      } else {
        printError(response["status"]);
      }
    },
    error: printError
  });
}

function clearFloor(floorId) {

    $.ajax({
        url: "/BluePrints/room/clearFloor",
        type: "POST",
        dataType: "json",
        data: {floorId: floorId},
        success: function(response) {
            var status = response["status"];

            if(status == "ok") {
                floorLayer.getSource().getFeatures().forEach(function(feature) {
                  floorLayer.getSource().removeFeature(feature);
                });
                deselectRoom();
                updateRoomTable(floorId);
            }

            console.log(status);
        },
        error: printError
    });

}



/**
 * Room Staff Functions
 */

function confirmUnassignment(staffId) {


    var staffName = $(".staffName[staffId='" + staffId + "']").html();
    $("#unassignStaffName").html(staffName);
    $("#unassignStaff").attr("staffId", staffId);
    $("#confirmUnassignmentModal").modal("show");
    console.log($("#confirmUnassignmentModal"));
}

function unassignStaff(roomId, staffId) {

  $.ajax({
    url: "/BluePrints/room/unassignStaff",
    type: "POST",
    dataType: "json",
    data: {
        roomId: roomId,
        staffId: staffId
    },
    success: function(response) {

        var status = response["status"];

        if(status == "ok") {
            updateRoomStaff(roomId);
            $("#confirmUnassignmentModal").modal("hide");
        } else {
          printError(status);
        }
    },
    error: printError
  });
}


function updateRoomStaff(roomId) {

  getRoomStaff(roomId, function(staff){
    var staffData = "";

    if(staff.length > 0) {
      for(var i = 0; i < staff.length; i++) {

          var staffRow = "<tr><td class='staffName' staffId='" + staff[i].id + "'>" + staff[i].name + "</td><td align='center'>"
          + "<button class='btn btn-danger' onClick='confirmUnassignment(\"" + staff[i].id + "\")' staffId='" + staff[i].id + "'>Unassign</button>"
          + "</td></tr>";

          staffData += staffRow;
      }
    } else {
      staffData = "<tr><td colspan='4' align='center'><b>No Staff Assigned</b></td></tr>"
    }



    $("#staffSection").html(staffData);
  });
}

function getRoomStaff(roomId, resultsFunction) {

  $.ajax({
    url: "/BluePrints/room/getRoomStaff",
    type: "GET",
    dataType: "json",
    data: {roomId: roomId},
    success: function(response) {
      var staff = response["staff"];

      if(typeof staff != 'undefined') {

        resultsFunction(staff);
      } else {
        printError(response["status"]);
      }
    },
    error: printError
  });
}

var staffAssignments = null;

function addStaff(staffId) {

    if(staffAssignments == null) {
      staffAssignments = [];
    }

    staffAssignments.push(staffId);

    $(".assignmentBtn[staffId='" + staffId + "']").attr("hidden", "");
    $(".unassignBtn[staffId='" + staffId + "']").removeAttr("hidden");

}

function removeStaff(staffId) {

  var index = staffAssignments.indexOf(staffId);
  staffAssignments.splice(index, 1);
  $(".assignmentBtn[staffId='" + staffId + "']"). removeAttr("hidden");
  $(".unassignBtn[staffId='" + staffId + "']").attr("hidden", "");
}

function resetStaffList() {
  $(".assignmentBtn").removeAttr("hidden");
  $(".unassignBtn").attr("hidden", "");

  staffAssignments = [];
}

function assignStaff(roomId, staffIds) {

    console.log(staffIds);

    $.ajax({
      url: "/BluePrints/room/assignStaffToRoom",
      type: "POST",
      dataType: "json",
      data: {
          roomId: roomId,
          staffIds: staffIds
      },
      success: function(response) {

          var status = response["status"];

          if(status == "ok") {
              updateRoomStaff(roomId);
              $("#addStaffModal").modal("hide");
          } else {
            printError(status);
          }
      },
      error: printError
    });
}

function getAllStaff(roomId) {

  $.ajax({
    url: "/BluePrints/staff/getAllStaff",
    type: "GET",
    dataType: "json",
    data: {roomId: roomId},
    success: function(response) {
      var staff = response["staff"];

      if(typeof staff != 'undefined') {

          var staffData = "";

          if(staff.length > 0) {

            for(var i = 0; i < staff.length; i++) {

                var staffRow = "<tr><td>" + staff[i].name + "</td><td>" + staff[i].email + "</td>"
                + "<td><button class='btn btn-default assignmentBtn' onClick='addStaff(\"" + staff[i].id + "\")' staffId='" + staff[i].id + "'>Add</button>"
                + "<button class='btn btn-default unassignBtn' onClick='removeStaff(\"" + staff[i].id + "\")' staffId='" + staff[i].id + "' hidden><span class='fas fa-times'></span></button>"
                + "</td></tr>";

                staffData += staffRow;
            }
          } else {

            staffData = "<tr><td colspan='4' align='center'><b>There is no staff to assign.</b></td></tr>";
          }



          $("#staffAssignmentList").html(staffData);
      } else {
        printError(response["status"]);
      }
    },
    error: printError
  });
}
