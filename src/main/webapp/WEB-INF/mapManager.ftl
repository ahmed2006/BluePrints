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

	<link rel="stylesheet" href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">

	<script src="/BluePrints/webjars/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
	<script src="/BluePrints/webjars/datatables/1.10.16/js/jquery.dataTables.js"></script>
	<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables_themeroller.css">
	<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables.css">

	<link rel="/BluePrints/css/mapManager.css">

</head>

<body>
	<#include "/inc/navbar.ftl">

	<h1 class="text-center">Map Management</h1>
		<table class="table" id="buildingTable">
			<thead style="background-color: #007bff; color: white;">
				<tr role="row"><th>
							<div class="row">
								<div class="col-sm-6">
									<h2>Buidlings</h2>
								</div>
								<div class="col-sm-6" align="right" style="padding-top: 5px;">
									 <button class="btn btn-primary" style="border: 2px solid white;" onclick="window.location='/BluePrints/mapManager/newBuilding'">Add Building</button>
								</div>
						</div>
					</th></tr>
			</thead>
			<tbody>
				<#list buildings as building>
					<tr><td>
						<div id="accordion${building.name}" class="accordion">
							<div class="card">
									<a class="collapsed card-link buildingLink" data-toggle="collapse" data-parent="#accordion${building.id}" href="#collapse${building.id}" style="z-index: 1;">
										<div class="card-header">
											<div class="row">
												<div class="col-sm-6">
													${building.name}
												</div>

												<div style="z-index: 2;" class="col-sm-6 buildingActions" name="buildingActions" align="right" hidden>
													<!-- <button class="btn btn-default view-btn" onclick="window.location='/BluePrints/mapManager/viewBuilding?buildingId=${building.id}'">View Building</button> -->
													<!-- <button class="btn btn-default edit-btn" buildingId="${building.id}">Edit Name</button> -->
													<button class="btn btn-default delete-btn" buildingId="${building.id}">Delete</button>
												</div>
											</div>
										</div>
									</a>

								<div id="collapse${building.id}" class="collapse">
									<div class="card-body">
										<table width="100%" class="table-bordered floorList">
											<#list floors[building.id]! as floor>

												<tr>
													<td scope="row">
														<a  style="text-decoration: none; z-index: 1; display: inline; outline: 0;" class="floorLink" href="javascript:;">
															<div class="row">
																<div class="col-lg-2 floorName">
																	Floor ${floor.name}
																</div>
																<div style="z-index: 2;" class="col-lg-10 floorActions" name="floorActions" align="right" hidden>
																	<button class="btn btn-default edit-btn-floor" onClick="window.location='/BluePrints/mapManager/floor/floorEditor?floorId=${floor.id}'">Edit</button>
																	<button class="btn btn-default duplicate-btn-floor" floorId="${floor.id}">Duplicate</button>
																	<button class="btn btn-default delete-btn-floor" floorId="${floor.id}">Delete</button>
																</div>
														</div>
														</a>
													</td>
												</tr>

											</#list>
										</table>
										<br>
										<button class="btn btn-primary addFloorBtn" buildingId="${building.id}">Add Floor</button>
									</div>
								</div>

							</div>
						</div>
					</td></tr>
				</#list>
			</tbody>
		</table>

	<div class="modal fade" id="editBuilding">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<span class="modal-title">Edit Building</span>
					</div>
					<div class="modal-body">
						<label><b>Building Name:</b></label>
						<input type="text" name="buildingName" id="buildingName" class="editorField form-control">
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="updateBuildingBtn">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="deleteBuilding">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-warning">
					<span class="modal-title">Delete Building</span>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete this building?</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn">Delete</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="deleteBuilding2">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-warning">
					<span class="modal-title">Delete Building</span>
				</div>
				<div class="modal-body">
					<p>
						Once this building has been deleted, all associated maps for this builidng will be deleted as well. <br>
						Would you still like to delete this building?
					</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn2">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="newFloor">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<span class="modal-title">New Floor</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<label class="col-sm-2"><b>Floor: </b></label>
							<input type="text" name="floorName" id="floorName" class="form-control col-sm-2">
						</div>
						<br>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="newFloorBtn">Add</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="duplicateFloorModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<span class="modal-title">Duplicate Floor</span>
					</div>
					<div class="modal-body">
						<div class="row">
							<label class="col-sm-2"><b>Floor: </b></label>
							<input type="text" name="duplicateFloorName" id="duplicateFloorName" class="form-control col-sm-2">
						</div>
						<br>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="duplicateFloorBtn">Add</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="errorEdit">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-danger">
					<span class="modal-title">Error: Updating Building</span>
				</div>
				<div class="modal-body">
					<p>
						This building could not be updated:
					</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="errorDelete">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-danger">
					<span class="modal-title">Error: Deleting Building</span>
				</div>
				<div class="modal-body">
					<p>
						This building could not be deleted:
					</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade successModal" id="successEdit">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-success">
					<span class="modal-title">Success: Updated Building</span>
				</div>
				<div class="modal-body">
					<p>
						This building was succesfully updated:
					</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade successModal" id="successDelete">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-success">
					<span class="modal-title">Success: Deleted Building</span>
				</div>
				<div class="modal-body">
					<p>
						This building was succesfully deleted:
					</p>
					<span class="deleteBuildingName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade successModal" id="successFloor">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-success">
					<span class="modal-title">Success: Add Floor</span>
				</div>
				<div class="modal-body">
					<p>
						The floor was successfully added.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteFloor">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-warning">
					<span class="modal-title">Delete Floor</span>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete this floor?</p>
					<span class="deleteFloorName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn-floor">Delete</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="deleteFloor2">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-warning">
					<span class="modal-title">Delete Floor</span>
				</div>
				<div class="modal-body">
					<p>
						Once this floor has been deleted, all associated rooms for this flooor will be deleted as well. <br>
						Would you still like to delete this building?
					</p>
					<span class="deleteFloorName" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn2-floor">Delete</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">

		$(document).ready(
				function() {

					//////////////////////////////////
					// Helper Functions
					/////////////////////////////////
					function deleteBuilding(buildingId, successFunction, errorFunction) {
							$.ajax({
								type : "POST",
								url : "/BluePrints/mapManager/deleteBuilding",
								dataType : "json",
								data : {
									buildingId : buildingId
								},
								success : successFunction,
								error : errorFunction
							});
					}

					function updateBuilding(buildingId, buildingName, successFunction, errorFunction) {
							$.ajax({
								type : "POST",
								url : "/BluePrints/mapManager/updateBuilding",
								dataType : "json",
								data : {
									buildingId : buildingId,
									buildingName : buildingName
								},
								success : successFunction,
								error : errorFunction
							});
					}

					function getBuildingInfo(buildingId, successFunction, errorFunction) {
							$.ajax({
								type : "GET",
								url : "/BluePrints/mapManager/getBuildingInfo",
								dataType : "json",
								data : {
									buildingId : buildingId
								},
								success : successFunction,
								error : errorFunction
							});
					}

					function printError(error) {
							console.log(error);
					}

					///////////////////////////////////////////////////////
					// Handles the functions of the datatable and buttons
					//////////////////////////////////////////////////////

					$('#buildingTable').DataTable({
							"bLengthChange" : false,
							"bSort": false,
					   	"order": [[0, 'asc']]
					});

					$(".buildingLink").click(function(e) {
							$(".buildingLink .active").attr("hidden", "");
							$(".buildingLink .active").removeClass("active");

							$(this).find(".buildingActions").removeAttr('hidden');
							$(this).find(".buildingActions").addClass("active");

							$(".collapse").collapse("hide");
					});



					$(".edit-btn").click(function(e) {
							e.preventDefault();
							e.stopPropagation();

							var id = $(this).attr("buildingId");

							var successFunction =  function(response) {

									if(response.hasOwnProperty("error")) {

										console.log(response["error"]);

									} else {
										var buildingName = response["buildingName"];
										console.log(buildingName);
										$("#buildingName").val(response["buildingName"]);
										$("#updateBuildingBtn").attr("buildingId", id);
									}

							}

							getBuildingInfo(id, successFunction, printError);
							$("#editBuilding").modal("show");
					});

					$("#updateBuildingBtn").click(function(e) {
						e.preventDefault();

						var id = $(this).attr("buildingId");
						var buildingName = $("#buildingName").val();

						var successFunction = function(response) {

							if (response['status'] == 'ok') {

								$(".deleteBuildingName").text(buildingName);
								$("#editBuilding").modal("hide");
								$("#successEdit").modal("show");

							} else {
								console.log(response['status']);
								$("#errorEdit").modal("show");
							}

						}

						var displayError = function(error) {
								console.log(error);
								$("#errorEdit").modal("show");
						}

						updateBuilding(id, buildingName, successFunction, displayError);

					});

					$(".delete-btn").click(
							function(e) {
								e.preventDefault();
								e.stopPropagation();

								var id = $(this).attr("buildingId");

								var successFunction = function(response) {

										var name = response["buildingName"];

										$(".deleteBuildingName").text(name);
										$("#delBtn").attr("buildingId", id);

								}

								getBuildingInfo(id, successFunction, printError);
								$("#deleteBuilding").modal("show");
							});

					$("#delBtn").click(function(e) {
						e.preventDefault();

						var id = $(this).attr("buildingId");
						$("#delBtn2").attr("buildingId", id);

						$("#deleteBuilding").modal("hide");
						$("#deleteBuilding2").modal("show");
					});

					$("#delBtn2").click(function(e) {

						e.preventDefault();
						var id = $(this).attr("buildingId");

						var successFunction = function(response) {
							if (response['status'] == 'ok') {
								$("#deleteBuilding2").modal("hide");
								$("#successDelete").modal("show");
							} else {
								console.log(response['status']);
								$("#errorDelete").modal("show");
							}

						}

						var displayError = function(error) {
								console.log(error);
								$("#errorDelete").modal("show");
						}
						deleteBuilding(id, successFunction, displayError);
					});

					$('.successModal').on('hide.bs.modal', function (e) {
					  location.reload();
					});

					///////////////////////////////////////
					// Floor Functions
					//////////////////////////////////////

					function addFloor(buildingId, floorName, successFunction, errorFunction) {
						$.ajax({
							url: "/BluePrints/mapManager/floor/addFloor",
							type: "POST",
							dataType: "json",
							data: {
								buildingId: buildingId,
								floorName: floorName
							},
							success: successFunction,
							error: errorFunction
						});
					}

					function duplicateFloor(floorId, newFloorName, success, error){
						$.ajax({
							url: "/BluePrints/mapManager/floor/duplicateFloor",
							type: "POST",
							dataType: "json",
							data: {
								floorId: floorId,
								newFloorName: newFloorName
							},
							success: success,
							error: error
						});
					}

					function deleteFloor(floorId, success, error){
						$.ajax({
							url: "/BluePrints/mapManager/floor/deleteFloor",
							type: "POST",
							dataType: "json",
							data: {
								floorId: floorId
							},
							success: success,
							error: error
						});
					}

					$(".floorLink").click(function(e) {
							$(".floorLink .active").attr("hidden", "");
							$(".floorLink .active").removeClass("active");

							$(this).find(".floorActions").removeAttr('hidden');
							$(this).find(".floorActions").addClass("active");
					});

					$(".addFloorBtn").click(function(e) {
						e.preventDefault();
						var buildingId = $(this).attr("buildingId");

						$("#newFloor").modal("show");
						$("#newFloorBtn").attr("buildingId", buildingId);
					});

					$(".delete-btn-floor").click(
							function(e) {
								e.preventDefault();
								e.stopPropagation();

								var id = $(this).attr("floorId");
								$("#delBtn-floor").attr("floorId", id);

							$("#deleteFloor").modal("show");
							});

					$("#delBtn-floor").click(function(e) {
						e.preventDefault();

						var id = $(this).attr("floorId");
						$("#delBtn2-floor").attr("floorId", id);

						$("#deleteFloor").modal("hide");
						$("#deleteFloor2").modal("show");
					});

					$("#delBtn2-floor").click(function(e) {

						e.preventDefault();
						var id = $(this).attr("floorId");

						var successFunction = function(response) {
							if (response['status'] == 'ok') {
								$("#deleteFloor2").modal("hide");
								$("#successDelete").modal("show");
							} else {
								console.log(response['status']);
								$("#errorDelete").modal("show");
							}

						}
						deleteFloor(id, successFunction, printError);
					});



					$("#newFloorBtn").click(function(e) {
						e.preventDefault();

						var buildingId = $(this).attr("buildingId");

						var floorName = $("#floorName").val();

						var successFunction = function(response) {

							var status = response["status"];

							console.log(status);
							console.log("Working");

							if(status == "ok") {

								$("#newFloor").modal("hide");
								$("#successFloor").modal("show");

							} else {
								console.log(status);
							}
						}

						addFloor(buildingId, floorName, successFunction, printError);
					});

					$(".duplicate-btn-floor").click(function(e) {

							var floorId = $(this).attr("floorId");
							$("#duplicateFloorBtn").attr("floorId", floorId);

							$("#duplicateFloorModal").modal("show");
					});

					$("#duplicateFloorBtn").click(function(e) {
							e.preventDefault();


							var newFloorName = $("#duplicateFloorName").val();
							var floorId = $(this).attr("floorId");

							if(newFloorName.trim() != "") {

								function successFunction(response) {
									 var status = response["status"];
									 console.log(status);
									 if(status == "ok") {
										 location.reload();
									 }
								}

								duplicateFloor(floorId, newFloorName, successFunction, printError);


							}
					});



				});
	</script>

</body>

</html>
