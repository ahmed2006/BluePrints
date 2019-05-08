<!DOCTYPE HTML>
<html>

<head>
<title>Login</title>
<meta charset="UTF-8" />

<script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.css">
<link rel="stylesheet" href="/BluePrints/css/login.css">


</head>

<body>

	<div class="container">
		<div class="row">
			<div class="card card-container login-container col-lg-6">
				<h1 class="text-center">BluePrints</h1>
				<h2 class="text-center">Login</h2>
				<hr>
				<form method="POST">
					<div class="form-group">
						<label for="email">Email: </label> <input type="text"
							name="email" id="email" placeholder="Email"
							class="form-control" value="${email!}" />
					</div>

					<div class="form-group">
						<label for="password">Password: </label> <input type="password"
							name="password" id="password" placeholder="Password"
							class="form-control" />
					</div>
					<input type="submit" id="loginBtn" value="Login" class="form-control">
					<br>
				</form>
				<br>
			</div>
		</div>
	</div>


	<#if error??>

		<div class="modal fade" id="loginError">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<span class="modal-title">Modal title</span>
					</div>
					<div class="modal-body">
						<p>${error}</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			$("#loginError").modal("show");
		</script>

	</#if>

</body>



</html>
