<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="/BluePrints/mapManager">BluePrints</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav col-lg-8">
      <li class="nav-item">
        <a class="nav-link" href="/BluePrints/users">User Management</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/BluePrints/mapManager">Manage Maps</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/BluePrints/categories">Manage Categories</a>
      </li>
    </ul>


    <form name="logoutForm" class="form-inline col-lg-4" action="/BluePrints/logout">
    	<div class="form-group col-sm-12">
	     	<span class="col-sm-6"><b>Welcome, ${activeUser.firstName!}</b></span>
	      	<input class="form-control col-sm-6" type="submit"  value="Logout" />
      	</div>
    </form>
  </div>
</nav>
