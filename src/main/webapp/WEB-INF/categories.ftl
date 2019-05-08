<#setting number_format="computer">
<!DOCTYPE HTML>
<html>

<head>
<title>BluePrints - Category Management</title>
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

	<h1 class="text-center">Category Management</h1>

		<table id="categoryTable">
			<thead style="background-color: #007bff; color: white;">
				<tr role="row"><th>
							<div class="row">
								<div class="col-sm-6">
									<h2>Categories</h2>
								</div>
								<div class="col-sm-6" align="right" style="padding-top: 5px;">
									 <button class="btn btn-primary" style="border: 2px solid white;" id="addButton">Add Category</button>
								</div>
						</div>
					</th></tr>
			</thead>
			<tbody>
				<#list categories as category>

					<tr><td>
						<div id="accordion${category}">
							<div class="card">
								<a class="collapsed card-link" data-toggle="collapse" data-parent="#accordion${category.name}" href="#collapse${category}">
									<div class="card-header">
											${category.name}
									</div>
								</a>

								<div id="collapse${category}" class="collapse">
									<div class="card-body">
										<button class="btn btn-default edit-btn" categoryName="${category.name}" catId = "${category.categoryID}">Edit</button>
										<button class="btn btn-default delete-btn" categoryName="${category.name}" catId = "${category.categoryID}">Delete</button>
									</div>
								</div>
							</div>
						</div>
					</td></tr>
				</#list>
			</tbody>
		</table>

	<div class="modal fade" id="addCategory">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">New Category</span>
				</div>
				<div class="modal-body">
					<form method="POST" id="newCategoryForm" onSubmit="return false">
						<div class="form-group">
							<label>Category Name:</label> <input type="text" id="name"
								name="catName" class="form-control">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="submitBtn">Add</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteCategory">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Delete Category</span>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to delete this category?</p>
					<span class="delete-user-name" style="font-weight: bold;"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-secondary" id="delBtn">Delete</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="deleteCategory2">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Delete Category</span>
				</div>
				<div class="modal-body">
					<p>
						Once this category has been deleted, this action can't be undone. <br>
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


	<div class="modal fade" id="editCategory">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<span class="modal-title">Edit Category</span>
				</div>
				<div class="modal-body">
					<form method="POST" id="editCategoryForm" onSubmit="return false">
						<div class="form-group">
							<label>Category Name:</label> <input type="text" id="newName"
								name="NewCatName" class="form-control">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary" id="updateCategoryBtn">Submit</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">

		$('.edit-btn').click(function(){
			var id = $(this).attr("catId");
			console.log(id);
			var oldName = $(this).attr("categoryName");
			console.log(oldName);
			$("#updateCategoryBtn").attr("oldName", oldName);
			$("#updateCategoryBtn").attr("catid", id);
			$("#editCategory").modal("show");
		});

		$('#updateCategoryBtn').click(function(){
			var oldName = $(this).attr("oldName");
			var newName = $("#newName").val();
			var id = $(this).attr("catid");
			console.log(id);

			$.ajax({
							type : "POST",
							url : "/BluePrints/category/editCategory",
							dataType : "json",
							data : {
								oldName : oldName,
								newName : newName,
								catId : id
							},
							success : function(data) {

								if (data['msg'] == 'ok') {
									$("#editCategory").modal("hide");
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

		$('.delete-btn').click(function(){
			var id = $(this).attr("catId");
			var name = $(this).attr("categoryName");
			$("#delBtn").attr("catid", id);
			$("#delBtn").attr("name", name);
			$("#deleteCategory").modal("show");

		});

		$('#delBtn').click(function(){
			var id = $(this).attr("catId");
			var name = $(this).attr("categoryName");
			$("#delBtn2").attr("catid", id);
			$("#delBtn2").attr("name", name);
			$("#deleteCategory2").modal("show");
		});

		$('#delBtn2').click(function(){

			var id = $(this).attr("catId");
			$.ajax({
							type : "POST",
							url : "/BluePrints/category/deleteCategory",
							dataType : "json",
							data : {
								catId : id
							},
							success : function(data) {

								if (data['msg'] == 'ok') {
										$("#deleteCategory").modal("hide");
										$("#deleteCategory2").modal("hide");
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


		$('#categoryTable').DataTable({
							"bLengthChange" : false,
							"order": [],
					    "aoColumns": [
					          null
					        ]
		});


		$("#addButton").click(function(e) {
			$("#addCategory").modal("show");
		});


		$("#submitBtn").click(function(){
			var categoryName = $("#newCategoryForm #name").val();
			$.ajax({
				type: "POST",
				url: "/BluePrints/category/addCategory",
				dataType: "json",
				data: {name: categoryName},
				success: function(data) {

					if(data['msg'] == 'ok'){
						$("#addCategory").modal("hide");

						location.reload();
					}
				},
				error: function(error){
					console.log("it broke...")
				}

			});
			$("#addCategory").modal("hide");
		});

	</script>


</body>

</html>
