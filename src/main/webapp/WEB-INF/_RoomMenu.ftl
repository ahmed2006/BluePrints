<div class="card roomPanel" hidden>
  <div class="card-header">
    Room Information
  </div>

  <div class="card-block col-lg-12">

    <div class="row">
      <div class="container-fluid">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/BluePrints/mapManager">${floor.building.name}</a></li>
            <li class="breadcrumb-item"><a href="javascript:;" onclick="floorBreadCrumbLink();">Floor ${floor.name}</a></li>
            <li class="breadcrumb-item active" aria-current="page" style="display: flex;">Room:&nbsp;<div id="roomNameBreadCrumb"></div></li>
          </ol>
        </nav>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-10">
        <br><h3><b>Room: </b></h3>
        <div class="form-group">
          <input type="text" id="roomName" value="" class="form-control">
          <input type="hidden" id="roomId" value="">
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <table class="table" border="1" id="staffTable">
          <thead class="thead-dark">
            <tr>
              <th colspan="4">
                <div class="row">
                  <div class="col-sm-6">
                    <h4><b>Staff</b></h4>
                  </div>
                  <div class="col-sm-6" align="right">
  								  <button class="btn btn-primary" style="border: 2px solid white; background-color: #212529;" id="addStaffBtn">Add Staff</button>
  								</div>
                </div>
            </th>

          </tr>
          </thead>
          <tbody id="staffSection">
            <!-- <col width="70%"><col width="30%"> -->
          </tbody>
        </table>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-6" align="left" style="margin: 0 0 0 10px;">
        <button type="button" class="btn btn-danger" id="deleteRoomBtn">
          <span class="fas fa-trash-alt"></span> Delete
        </button>

        <button class='btn btn-info' onclick="promptDuplicate($('#roomId').val(), '${floor.id}')">
          <i class='far fa-copy'></i> Duplicate
        </button>
      </div>
      <div class="col-lg-6" align="right" style="margin: 0 0 10px -10px;">
          <button type="button" class="btn btn-secondary" id="discardRoomChanges">Cancel</button>
          <button type="button" class="btn btn-primary" id="saveRoomBtn"> <span class="fas fa-save"></span> Save</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="addStaffModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title">Add Staff</span>
      </div>
      <div class="modal-body">
        <table class="table" id="staffAssignmentTable">
          <thead>
              <tr><th>Name</th><th>Email</th><th>Action</th></tr>
          </thead>
          <tbody id="staffAssignmentList">

          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="assignStaff">Assign</button>
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="duplicateModal">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <span class="modal-title">Duplicate Room</span>
        </div>
        <div class="modal-body">

          <div class="row">
            <div class="form-group col-lg-8">
              <label for="duplicateName">Room Name:</label>
              <input type="text" id="duplicateName" placeholder="Enter Name" class="form-control">
            </dv>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-primary" id="duplicateRoomBtn">Duplicate</button>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="confirmUnassignmentModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-warning">
        <span class="modal-title">Unassign Staff</span>
      </div>
      <div class="modal-body">
        <div style="display: flex;">
            <div>Are you sure you want to unassign:</div>&nbsp;<b><div class="p" id="unassignStaffName"></div></b>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-secondary" id="unassignStaff">Unassign</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

$("#addStaffBtn").click(function(e) {

  e.preventDefault();
  var roomId = $("#roomId").val();

  getAllStaff(roomId);

  $("#addStaffModal").modal("show");

});

function floorBreadCrumbLink() {

  var roomId = $("#roomId").val();

  getRoomFromLayer(roomId, floorLayer, function(roomFeature) {
      ifRoomIsModified(roomFeature, function() {
         $("#cancelModal").modal('show');
      },
      function() {
        deselectRoom();
      });
  });

}

$("#assignStaff").click(function() {

  var roomId = $("#roomId").val();

  if(staffAssignments != null && staffAssignments.length > 0) {
    assignStaff(roomId, staffAssignments);
  }

});

$("#unassignStaff").click(function(e) {
    e.preventDefault();

    var staffId = $(this).attr("staffId");
    var roomId = $("#roomId").val();
    unassignStaff(roomId, staffId);
});

$("#addStaffModal").on("hide.bs.modal", function(e) {

    resetStaffList();
});

$("#duplicateRoomBtn").click(function(e) {
    e.preventDefault();

    var roomName = $("#duplicateName").val();

    if(roomName.trim() != "") {

        var roomId = $(this).attr("roomId");
        var floorId = $(this).attr("floorId");

        getRoomFromLayer(roomId, floorLayer, function(roomFeature) {

            var coordinateData = convertFeatureToJSON(roomFeature);
            var duplicateFeature = convertJSONtoFeature(coordinateData);

            addRoom(floorId, roomName, coordinateData, function(duplicateRoomId) {

                  if(roomId != null) {

                    duplicateFeature.set("roomId", duplicateRoomId);
      							map.addInteraction(floorSelector);
      							updateRoomTable(floorId);
      							selectRoom(duplicateRoomId);

                    getRoomStaff(roomId, function(staff) {
                        var staffIds = [];
                        for(var i = 0; i < staff.length; i++) {
                            staffIds.push(staff[i].id);
                        }

                        assignStaff(duplicateRoomId, staffIds);
                    });

                    floorLayer.getSource().addFeature(duplicateFeature);
                    $("#duplicateModal").modal("hide");
                  }

    				});


        });

    }
});

</script>
