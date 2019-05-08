<#setting number_format="computer">
<!DOCTYPE HTML>
<html>

<head>
<title>BluePrints - Map Management</title>
<meta charset="UTF-8" />

<script src="/BluePrints/webjars/jquery/3.0.0/jquery.js"></script>
	<script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
	<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
	<script src="/BluePrints/webjars/popper.js/1.12.9/dist/umd/popper.min.js"></script>
	<script src="https://openlayers.org/en/v4.6.5/build/ol.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
	<script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
	<link rel="stylesheet" href="/BluePrints/css/comments.css">
	<link rel="stylesheet" href="https://cdn.rawgit.com/Viglino/ol-ext/master/dist/ol-ext.min.css" />
	<script type="text/javascript" src="https://cdn.rawgit.com/Viglino/ol-ext/master/dist/ol-ext.min.js"></script>
	<link rel="stylesheet" href="/BluePrints/css/roomCSS.css">

	<link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome.css">
	<link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome.min.css">
	<link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome-all.css">
	<link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome-all.min.css">
	<link rel="stylesheet" href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.css">
	<link rel="stylesheet" href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables_themeroller.css">
	<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables.css">
	<script src="/BluePrints/webjars/jquery/3.0.0/jquery.js"></script>
	<script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
	<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.js"></script>
	<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>




	<style>
			.map {

				height: 570px;
				width: 100%;
			}
	</style>

</head>

<body style="height: 100%;">
	<#include "/inc/navbar.ftl">

	<h1 class="text-center">Floor Editor</h1>

  <hr>
  <div class="row" style="height: inherit; width: 100%; position: absolute;">
    <div class="col-md-7" style="left: 50px">
      <#include "/mapDisplay.ftl">
    </div>

	  <div class="col-lg-5">
			  <#include "/_FloorMenu.ftl">
				<#include "/_RoomMenu.ftl">
		</div>

		<!--Modal Begin Here-->
		<div class="modal fade" id="addRoomModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-info">
						<span class="modal-title">Add Room</span>
					</div>
					<div class="modal-body">
						<form onSubmit="return false">
							<label>Room Name:</label>
							<input type="text" name="newRoomName" id="newRoomName" placeholder="Enter Name" class="form-control">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="addRoomBtn">Add</button>
					</div>
				</div>
			</div>
		</div>


		<div class="modal fade" id="cancelModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Discarding Changes</span>
					</div>
					<div class="modal-body">
						<p>All unsaved changes will be discarded, are you sure you want to continue? </p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="cancelDiscardBtn">Cancel</button>
						<button type="button" class="btn btn-secondary" id="discardBtn">Discard</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="confirmDeleteRoom1">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Deleting Room</span>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete Room: <span class="deleteRoomName"></span>? </p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-secondary" id="confirmDeleteRoomBtn1">Delete</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="confirmDeleteRoom2">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Deleting Room</span>
					</div>
					<div class="modal-body">
						<p>Once this room is deleted it can't be undo.</p>
						<p>Are you sure you still want to delete Room: <span class="deleteRoomName"></span>? </p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-secondary" id="confirmDeleteRoomBtn2">Delete</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="firstConfirmClearModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Clearing Floor</span>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to clear this floor? </p>
						<p>Total Room:&nbsp; <b><span class="roomTotal"></span></b></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-secondary" id="confirmClearBtn1">Clear</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="secondConfirmClearModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Clearing Floor</span>
					</div>
					<div class="modal-body">
						<p><b>Once this floor is cleared, it can't be undo.</b></p>
						<p>Are you sure you still want to clear this floor? </p>
						<p>Total Room:&nbsp; <b><span class="roomTotal"></span></b></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-secondary" id="confirmClearBtn2">Clear</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="editComment">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-info">
						<span class="modal-title">Edit Comment</span>
					</div>
					<div class="modal-body">
						<form onSubmit="return false">
							<label>Comment:</label>
							<input type="text" name="editCommentMsg" id="editCommentMsg" placeholder="Enter Comment" class="form-control">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="updateCommentBtn">Save</button>
					</div>
				</div>
			</div>
		</div>

    <div class="modal fade" id="deleteComment">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-info">
						<span class="modal-title">Delete Comment</span>
					</div>
					<div class="modal-body">
            <p>Are you sure you want to delete this comment</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-danger" id="deleteCommentBtn">Delete</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade success" id="successSaved">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-success">
						<span class="modal-title">Success: Saved Floor</span>
					</div>
					<div class="modal-body">
						<p>This floor was successfully saved.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="errorSaving">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Error: Saving floor</span>
					</div>
					<div class="modal-body">
						<p>This floor could not be saved. Please check that your fields are properly filled out and try again</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
					</div>
				</div>
			</div>
		</div>
		<!--Modals End Here-->
</div>

<script type="text/javascript" src="/BluePrints/js/roomFunctions.js"></script>
<script type="text/javascript" src="/BluePrints/js/floorCommentFunctions.js"></script>
<script type="text/javascript">


	function hasSameCoordinates(feature, otherFeature) {

		var sameCoordinates = true;

		var featureCoordinates = feature.getGeometry().getCoordinates()[0];
		var otherCoordinates = otherFeature.getGeometry().getCoordinates()[0];

		if(featureCoordinates.length == otherCoordinates.length) {

			var i = 0;
			var done = false;

			while(!done && i < featureCoordinates.length) {
				var featureLon = featureCoordinates[i][LONGITUDE];
				var featureLat = featureCoordinates[i][LATITUDE];

				var otherLon = otherCoordinates[i][LONGITUDE];
				var otherLat = otherCoordinates[i][LATITUDE];


				if(featureLon != otherLon || featureLat != otherLat) {
					sameCoordinates = false;
					done = false;
				}

				i++;
			}
		}

		return sameCoordinates;
	}

	function ifRoomIsModified(currentRoomFeature, trueAction, falseAction) {

		var roomName = $("#roomName").val();
		var roomId = $("#roomId").val();

		getRoom(roomId, function(room) {

			var modified = true;

			if(room.name == roomName) {

					var roomFeature = convertJSONtoFeature(room.coordinates);
					if(hasSameCoordinates(currentRoomFeature, roomFeature)) {
							modified = false;
					}
			}

			if(modified) {

				if(trueAction != null) {
					trueAction();
				}

			} else {

				if(falseAction != null) {
					falseAction();
				}

			}
		});
	}

	function printError(error) {
			console.log(error);
	}

	function getCoordinates() {

		$.ajax({

			url: "/BluePrints/mapManager/getBuildingCoordinates",
			type: "GET",
			dataType: "json",
			data: {
				buildingId: "${floor.building.id}"
			},
			success: function(response) {

				var coordinateData = response["coordinateData"];

				rehydrateMap(coordinateData, vectorLayer);
				resetZoom();

			},
			error: printError
		});

	}

	function selectRoomRow(roomId) {


	  	getRoomFromLayer(roomId, floorLayer, function(roomFeature) {

					floorSelector.getFeatures().push(roomFeature);
					selectRoom(roomId);
			});
	}

	$(".cancel").click(function(e) {
		e.preventDefault();
		$("#cancelModal").modal("show");
	});

	$("#saveBtn").click(function(e) {
			e.preventDefault();

			var editorId = $("#editorId").val();

			var successFunction = function (response) {

				var status = response["status"];

				if(status == "ok") {
					$("#successSaved").modal("show");
				} else {
					$("#errorSaving").modal("show");
				}
			}

			var errorFunction = function(error) {
				conosle.log(error);
			}
	});

	$("#drawRoom").click(function(e) {

		$("#newRoomName").val("");
		$("#addRoomModal").modal("show");
	});

	$("#addRoomBtn").click(function(e) {
			e.preventDefault();



			function proccessCoordinateData(roomFeature) {

			  var roomName = $("#newRoomName").val();
				var floorId = "${floor.id}";

			  addRoom(floorId, roomName, convertFeatureToJSON(roomFeature), function(roomId) {
							roomFeature.set("roomId", roomId);
							map.addInteraction(floorSelector);
							updateRoomTable(floorId);
							selectRoom(roomId);
				});

			}

			$("#addRoomModal").modal("hide");
			map.removeInteraction(floorSelector);
			drawSquare(proccessCoordinateData);
	});

	$("#discardRoomChanges").click(function(e) {
			e.preventDefault();

			var roomId = $("#roomId").val();

			getRoomFromLayer(roomId, floorLayer, function(roomFeature) {

				ifRoomIsModified(roomFeature, function() {
					 $("#cancelModal").modal('show');
				},
				function() {
					deselectRoom();
				});

			});

	});

	$("#cancelDiscardBtn").click(function(e) {
			e.preventDefault();

			var roomId = $("#roomId").val();

			getRoomFromLayer(roomId, floorLayer, function(roomFeature) {

				console.log(floorSelector.getFeatures().getLength());
				if(floorSelector.getFeatures().getLength() <= 0) {

						floorSelector.getFeatures().push(roomFeature);
				}

				floorTransform.setActive(true);
				floorTransform.select(roomFeature);

			});

	});

	$("#saveRoomBtn").click(function(e) {
			e.preventDefault();


			var roomName = $("#roomName").val();
			var roomId = $("#roomId").val();
			var roomCoordinteData = null;

			var features = getSelectedRoomFeatures();
			features.forEach(function(roomFeature) {

				roomCoordinteData = convertFeatureToJSON(roomFeature);

				updateRoom("${floor.id}", roomId, roomName, roomCoordinteData);
			});
	});

	$("#deleteRoomBtn").click(function(e) {

		var roomId = $("#roomId").val();
		var roomName = $("#roomName").val();
		$("#confirmDeleteRoom1").modal("show");
	});

	$("#confirmDeleteRoomBtn1").click(function(e) {
		e.preventDefault();
		$("#confirmDeleteRoom1").modal("hide");
		$("#confirmDeleteRoom2").modal("show");
	});

	$("#confirmDeleteRoomBtn2").click(function(e) {
		e.preventDefault();

		var roomId = $("#roomId").val();
		var features = getSelectedRoomFeatures();

		features.forEach(function(roomFeature) {

			deleteRoom(roomId, "${floor.id}", roomFeature);
		});

		$("#confirmDeleteRoom2").modal("hide");

	});

	$("#discardBtn").click(function(e) {

			e.preventDefault();

			var roomId = $("#roomId").val();
			$("#cancelModal").modal("hide");
			getRoom(roomId, function(room) {
				getRoomFromLayer(roomId, floorLayer, function(roomFeature) {

					 floorLayer.getSource().removeFeature(roomFeature);
					 var prevRoomFeature = convertJSONtoFeature(room.coordinates);
					 floorLayer.getSource().addFeature(prevRoomFeature);
					 prevRoomFeature.set("roomId", roomId);

					 deselectRoom();
				});
			});

	});


	$("#clearBtn").click(function(e) {
			e.preventDefault();

			var roomTotal = floorLayer.getSource().getFeatures().length;

			$(".roomTotal").html(roomTotal);
			$("#firstConfirmClearModal").modal("show");
	});

	$("#confirmClearBtn1").click(function(e) {
			e.preventDefault();
			$("#firstConfirmClearModal").modal("hide");
			$("#secondConfirmClearModal").modal("show");
	});

	$("#confirmClearBtn2").click(function(e) {
			e.preventDefault();
			$("#secondConfirmClearModal").modal("hide");
			clearFloor("${floor.id}");
	});


	$('.successModal').on('hide.bs.modal', function (e) {
		location.reload();
	});

	/*
	 * Comment System.
	 */

	$("#sendMessageBtn").click(function(e) {
 		e.preventDefault();

		console.log("Clicking");
		var commentMsg = $("#commentMsg").val();
		commentMsg = commentMsg.trim();

		var successFunction = function(response) {

				var status = response["status"];

				if(status == "ok") {
					$("#commentMsg").val("");
					reloadComments("${floor.id}");
				} else {
					console.log(status);
				}
		}

		if(commentMsg != "") {
			addComment("${floor.id}", "${activeUser.id}", commentMsg, successFunction, printError);
		}

	});

	function editCommentPopup(commentId) {

		var commentMsg = $("#" + commentId).text();

		$("#editCommentMsg").val(commentMsg);
		$("#updateCommentBtn").attr("commentId", commentId);
		$("#editComment").modal("show");
	}

  function deleteCommentPopup(commentId) {
    $("#deleteComment").modal("show");
    $("#deleteCommentBtn").attr("commentId", commentId);
  }

	$("#updateCommentBtn").click(function(e) {

		console.log("Clicked");

		var commentId = $("#updateCommentBtn").attr("commentId");
		var commentMsg = $("#editCommentMsg").val();
		commentMsg = commentMsg.trim();

		var successFunction = function(response) {

				var status = response["status"];

				if(status == "ok") {

					reloadComments("${floor.id}");
					$("#editComment").modal("hide");
				} else {
					console.log(status);
				}
		}

		if(commentMsg != "") {
			updateComment("${activeUser.id}", commentId, commentMsg, successFunction, printError);
		}
	});

  $("#deleteCommentBtn").click(function(e) {

    console.log("Clicked");

    commentId = $("#deleteCommentBtn").attr("commentId");

    var successFunction = function(response) {
      var status = response["status"];

      if(status == "ok") {
        reloadComments("${floor.id}");
        $("#deleteComment").modal("hide");
      } else {
        console.log(status);
      }
    }

    deleteComment("${activeUser.id}", commentId, successFunction, printError);

  });


	$(document).ready(function() {

			raster.setVisible(false);

			reloadComments("${floor.id}");
			getCoordinates();
			getRoomCoordinates("${floor.id}");

			floorSelector.on('select', function(e) {
				 var features = e.selected;

				 if(features.length > 0) {
					 var roomFeature = e.selected[0];
					 var roomId = roomFeature.get("roomId");
					 var isRoomPanelHidden = $(".roomPanel").attr("hidden");

					 	if(typeof isRoomPanelHidden != 'undefined') {

						 	selectRoom(roomId);
					 	} else {

						 	var currentlySelectedId = $("#roomId").val();

							floorSelector.getFeatures().clear();
							floorTransform.setActive(false);
							getRoomFromLayer(currentlySelectedId, floorLayer, function(currentSelectedRoomFeature) {
									floorSelector.getFeatures().push(currentSelectedRoomFeature);

									ifRoomIsModified(currentSelectedRoomFeature, function() {
										 $("#cancelModal").modal('show');
									},
									function() {
										deselectRoom();
										floorSelector.getFeatures().push(roomFeature);
										selectRoom(roomId);
									});
							});

					 }

				 } else {

						ifRoomIsModified(e.deselected[0], function() {
							 $("#cancelModal").modal('show');
						},
						function() {
							deselectRoom();
						});
				 }

			});

			map.addInteraction(floorTransform);
			floorTransform.setActive(false);

			map.addInteraction(floorSelector);
			updateRoomTable("${floor.id}");

			$("a[href='https://openlayers.org/']").css("display", "none");
	});


	map.on("pointerdrag", function() {


			if(floorTransform.getActive() && typeof floorTransform.feature_ != undefined && floorTransform.feature_ != null) {

				var roomId = $("#roomId").val();

				if(roomId != floorTransform.feature_.get("roomId")) {

						getRoomFromLayer(roomId, floorLayer, function(roomFeature) {
							ifRoomIsModified(roomFeature, function() {
								 $("#cancelModal").modal('show');
							},
							function() {
								deselectRoom();
							});
						});

				}

			}
	});


</script>


</body>

</html>
