<#setting number_format="computer">
<!DOCTYPE HTML>
<html>

<head>
<title>BluePrints - User Management</title>
<meta charset="UTF-8" />

<script src="/BluePrints/webjars/jquery/3.0.0/jquery.js"></script>
<script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
<script src="/BluePrints/webjars/popper.js/1.12.9/dist/umd/popper.min.js"></script>
<link rel="stylesheet"	href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">

<script src="/BluePrints/webjars/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="/BluePrints/webjars/datatables/1.10.16/js/jquery.dataTables.js"></script>
<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables_themeroller.css">
<link rel="stylesheet" href="/BluePrints/webjars/datatables/1.10.16/css/jquery.dataTables.css">

</head>

<body>
	<#include "/inc/navbar.ftl">

	<h1 class="text-center">User Management</h1>

		<table id="userTable">
			<thead style="background-color: #007bff; color: white;">
				<tr role="row"><th>
							<div class="row">
								<div class="col-sm-6">
									<h2>Users</h2>
								</div>
								<div class="col-sm-6" align="right" style="padding-top: 5px;">
									<button class="btn btn-primary add-btn" style="border: 2px solid white;">Add User</button>
								</div>
						</div>
					</th></tr>
			</thead>
			<tbody>
				<#list users as user>
					<tr><td>
						<div id="accordion${user.id}">
							<div class="card">
								<a class="collapsed card-link userLink" data-toggle="collapse" data-parent="#accordion${user.id}" userId="${user.id}" href="#collapse${user.id}" style="z-index: 1;">
									<div class="card-header">
											<div class="row">
												<div class="col-sm-6">
													${user.firstName} ${user.lastName}
												</div>

												<div style="z-index: 2;" class="col-sm-6 userActions" name="userActions" align="right" hidden>
													<button class="btn btn-default edit-btn" userId="${user.id}">Edit Role</button>
													<button class="btn btn-default delete-btn" userId="${user.id}">Delete</button>
												</div>
											</div>
										</div>
									</a>
							<div id="collapse${user.id}" class="collapse">
									<div class="card-body">
										<label><b>First Name:</b> </label> <span id="editFN${user.id}"> </span> <br>
										<label><b>Last Name:</b> </label> <span id="editLN${user.id}"> </span> <br>
										<label><b>E-mail: </b> </label> <span id="editEmail${user.id}"> </span> <br>
										<label><b>Role: </b> </label> <span id="editRole${user.id}"> </span> <br>
									</div>
								</div>
							</div>
						</div>
					</td></tr>
				</#list>
			</tbody>
		</table>


	<div class="modal fade" id="viewUser">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">View User</span>
				</div>
				<div class="modal-body">
					<label><b>First Name:</b> </label> <span id="viewFN"> </span> <br>
					<label><b>Last Name:</b> </label> <span id="viewLN"> </span> <br>
					<label><b>E-mail: </b> </label> <span id="viewEmail"> </span> <br>
					<label><b>Role: </b></label> <span id="viewRole"> </span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="editBtn">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editUser">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Edit Role</span>
				</div>
				<div class="modal-body">
					<label><b>Role: </b></label>
					<select id="editRole">
						<#list roles as role>
							<option value="${role.id}">${role.name}</option>
						</#list>
					</select>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="updateUserBtn">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteUser">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Delete User</span>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete this user?</p>
					<span class="delete-user-name" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteUser2">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Delete User</span>
				</div>
				<div class="modal-body">
					<p>
						Once this user has been deleted, this action can't be undone. <br>
						Would you still like to delete this user?
					</p>
					<span class="delete-user-name" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn2">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="addUser">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">New User</span>
				</div>
				<div class="modal-body">
					<form method="POST" id="newUserForm" onSubmit="return false">

						<div class="form-group">
							<label for="firstName">First Name:</label> <input type="text" id="firstName"
								name="firstName" class="form-control">
						</div>
						<div class="form-group">
							<label for="lastName">Last Name:</label> <input type="text" id="lastName"
								name="lastName" class="form-control">
						</div>
					<div class="form-group">
							<label for="email">Email:</label> <input type="text" id="email"
								name="email" class="form-control">
					</div>

						<div class="form-group">
							<label for="userRole">Role:</label>
							<select id="userRole" class="form-control">
								<#list roles as role>
									<option value="${role.id}">${role.name}</option>
								</#list>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="addBtn">Add</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="authActiveDirectory">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Active Directory Authorization</span>
				</div>
				<div class="modal-body">
					<p><b>Enter you password to complete this action.</b></p>

					<form method="POST" id="authForm" onSubmit="return false">
						<div class="form-group">
							<label for="adPass">Password:</label>
							<input type="password" id="adPass" name="adPass" class="form-control" placeholder="Password">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="adSubmit">Submit</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#userTable').DataTable({
							"bLengthChange" : false,
							"order": [],
					    "aoColumns": [
					          null
					        ]
					});

					$(".add-btn").click(function() {

						$("#addUser").modal("show");

					});

					$("#addBtn").click(function(e) {


						e.preventDefault();

						var emailReg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+/i

						var email = $("#newUserForm #email").val();

						var firstName = $("#newUserForm #firstName").val();
						var lastName = $("#newUserForm #lastName").val();
						var email = $("#newUserForm #email").val();
						var roleId = $("#newUserForm #userRole").val();

						if(email.match(emailReg)) {
								addUser(firstName, lastName, email, roleId);
						} else {
							console.log("Invalid Email");
						}
					});

					function addUser(firstName, lastName, email, roleId) {

						$.ajax({
							type : "POST",
							url : "/BluePrints/users/addUser",
							dataType : "json",
							data : {
								firstName: firstName,
								lastName: lastName,
								email: email,
								userRole : roleId
							},
							success : function(data) {
								if (data['msg'] == 'ok') {

									$("#addUser").modal("hide");
									$("#authActiveDirectory").modal("hide");

									location.reload();
								} else {
									console.log(data['msg']);
								}
							},
							error : function(error) {
								console.log("it broke...")
							}
						});
					};

					$("#updateUserBtn").click(function(e) {
						e.preventDefault();

						var id = $(this).attr("userId");
						var role = $("#editRole").val();

						console.log(id + "In updateUserBtn");

						$.ajax({
							type : "POST",
							url : "/BluePrints/users/updateUserInformation",
							dataType : "json",
							data : {
								userId : id,
								userRole : role
							},
							success : function(data) {

								if (data['msg'] == 'ok') {
									$("#editUser").modal("hide");
									location.reload();
								} else {
									console.log(data['msg']);
								}

							},
							error : function(error) {
								console.log("it broke...")
							}
						});

					});

					$(".edit-btn").click(function(e) {
						e.preventDefault();
						e.stopPropagation();
						var id = $(this).attr("userId");
						$("#updateUserBtn").attr("userId", id);
						$("#editUser").modal("show");
					});

					$(".view-btn").click(function(e) {
						e.preventDefault();
						var id = $(this).attr("userId");

						$.ajax({
							type : "GET",
							dataType : "json",
							url : "/BluePrints/users/getUserInformation",
							data : {
								userId : id
							},
							success : function(data) {
								$("#viewFN").text(data["FirstName"]);
								$("#viewLN").text(data["LastName"]);
								$("#viewEmail").text(data["Email"]);
								$("#viewRole").text(data["Role"]);
								$("#editBtn").attr("userId", id);
							},
							error : function(error) {
								console.log(error);
							}
						});

						$("#viewUser").modal("show");
					});

					$(".delete-btn").click(
							function(e) {
								e.preventDefault();
								e.stopPropagation();
								var id = $(this).attr("userId");

								$.ajax({
									type : "GET",
									dataType : "json",
									url : "/BluePrints/users/getUserInformation",
									data : {
										userId : id
									},
									success : function(data) {

										var name = data["FirstName"] + " "
												+ data["LastName"] + " ("
												+ data["Email"] + ")";

										$(".delete-user-name").text(name);
										$("#delBtn").attr("userId", id);

									},
									error : function(error) {
										console.log(error);
									}
								});

								$("#deleteUser").modal("show");
							});

					$("#delBtn").click(function(e) {
						e.preventDefault();

						var id = $(this).attr("userId");
						$("#delBtn2").attr("userId", id);

						$("#deleteUser").modal("hide");
						$("#deleteUser2").modal("show");
					});

					$("#delBtn2").click(function(e) {
						e.preventDefault();
						var id = $(this).attr("userId");

						$.ajax({
							type : "POST",
							dataType : "json",
							url : "/BluePrints/users/deleteUser",
							data : {
								userId : id
							},
							success : function(data) {
								if (data['msg'] == 'ok') {
									$("#deleteUser2").modal("hide");
									location.reload();
								} else {
									console.log(data['msg']);
								}

							},
							error : function(error) {
								console.log(error);
							}
						});
					});
				});

				$(".userLink").click(function(e) {
							$(".userLink .active").attr("hidden", "");
							$(".userLink .active").removeClass("active");

							$(this).find(".userActions").removeAttr('hidden');
							$(this).find(".userActions").addClass("active");

							$(".collapse").collapse("hide");

							var id = $(this).attr("userId");

							console.log(id);

						$.ajax({
							type : "GET",
							dataType : "json",
							url : "/BluePrints/users/getUserInformation",
							data : {
								userId : id
							},
							success : function(data) {
								$("#editFN" + id).text(data["FirstName"])
								$("#editLN"+ id).text(data["LastName"])
								$("#editEmail"+ id).text(data["Email"])
								$("#editRole"+ id).text(data["Role"])
							},
							error : function(error) {

							}
						});
					});
	</script>


</body>

</html>
