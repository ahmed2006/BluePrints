<!DOCTYPE HTML>
<html>

<head>
<title>Password Reset</title>
<meta charset="UTF-8" />

<script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
<script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.css">


</head>

<body>

	<div class="container">
		<div class="row">
			<div class="card card-container col-lg-6 offset-lg-3" style="top: 20%; transform: perspective(1px) translateY(20%);">
				<h1 class="text-center">BluePrints</h1>
				<h2 class="text-center">Password Reset</h2>
				<hr>
				<form method="POST">
					<div class="form-group">
						<label for="email">Email: </label> <input type="text"
							name="email" id="email" placeholder="Email"
							class="form-control" value="${email!}" />
					</div>

          <div class="form-group">
						<label for="oldPassword">Old Password: </label> <input type="password"
							name="oldPassword" id="oldPassword" placeholder="Old Password"
							class="form-control" />
					</div>

					<div class="form-group">
						<label for="newPassword">New Password: </label> <input type="password"
							name="newPassword" id="newPassword" placeholder="New Password"
							class="form-control" />
					</div>

          <div class="form-group">
						<label for="confirmPassword">Confirm Password: </label> <input type="password"
							name="confirmPassword" id="confirmPassword" placeholder="Confirm Password"
							class="form-control" />
					</div>

					<input type="submit" id="changePasswordBtn" value="Change Password" class="form-control">
          <br>
          <input type="submit" id="backBtn" value="Cancel" class="form-control">
          <br>
				</form>
				<br>
			</div>
		</div>
	</div>


	<div class="modal fade" id="errorModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-danger">
					<span class="modal-title">Error</span>
				</div>
				<div class="modal-body">

          <div id="errorMsg"></div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

  <div class="modal fade" id="successModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header alert-success">
					<span class="modal-title">Success</span>
				</div>
				<div class="modal-body">

          Password was successfully reset.

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">

      function changePassword(userEmail, oldPassword, newPassword) {

        console.log(userEmail);

        $.ajax({
          url: "/BluePrints/users/changePassword",
          type: "POST",
          dataType: "json",
          data: {
            email: userEmail,
            oldPassword: oldPassword,
            newPassword: newPassword
          },
          success: function(response) {

            var status = response['msg'];

            if(status == "ok") {
              console.log("Successful");
              $("#successModal").modal("show");
            } else {
              console.log(status);
              $("#errorMsg").text(status);
              $("#errorModal").modal("show");
            }
          },
          error: function(error) {
            console.log(error);
          }
        });
      }

      $(document).ready(function() {



        $("#changePasswordBtn").click(function(e) {

          e.preventDefault();

          var email = $("#email").val();
          var oldPassword = $("#oldPassword").val();
          var newPassword = $("#newPassword").val();
          var confirmPassword = $("#confirmPassword").val();

          if(confirmPassword == newPassword) {
            changePassword(email, oldPassword, newPassword);
          } else {

            $("#errorMsg").text("New Password does not match your Confirmed Password.");
            $("#errorModal").modal("show");
            console.log("New Password does not match your Confirmed Password.");
          }


        });

        $('#successModal').on('hide.bs.modal', function (e) {
      		window.location = "/BluePrints/login";
      	});




      });

	</script>


</body>



</html>
