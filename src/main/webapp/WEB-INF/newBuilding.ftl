<#setting number_format="computer">
<!DOCTYPE HTML>
<html>

<head>
<title>BluePrints - Map Management</title>
<meta charset="UTF-8" />

            <link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome.css">
            <link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome.min.css">
            <link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome-all.css">
            <link rel="stylesheet" href="/BluePrints/css/fontawesome/css/fontawesome-all.min.css">
            <script src="/BluePrints/webjars/jquery/3.0.0/jquery.js"></script>
            <script src="/BluePrints/webjars/jquery/3.0.0/jquery.min.js"></script>
            <script src="/BluePrints/webjars/bootstrap/4.0.0-beta.3/js/bootstrap.min.js"></script>
            <script src="/BluePrints/webjars/popper.js/1.12.9/dist/umd/popper.min.js"></script>
            <script src="https://openlayers.org/en/v4.6.5/build/ol.js" type="text/javascript"></script>
            <link rel="stylesheet" href="/BluePrints/webjars/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
            <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
            <link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
            <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
            <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
            <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
            <script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="/BluePrints/css/coordinates.css">
            <link rel="stylesheet" href="https://cdn.rawgit.com/Viglino/ol-ext/master/dist/ol-ext.min.css" />
          	<script type="text/javascript" src="https://cdn.rawgit.com/Viglino/ol-ext/master/dist/ol-ext.min.js"></script>
            <style>
               .map {
               height: 570px;
               width: 100%;
               }
            </style>

</head>

<body style="height: 100%;">
	<#include "/inc/navbar.ftl">

	<h1 class="text-center">Create New Building</h1>

  <hr>
  <div class="row" style="height: inherit; width: 100%; position: absolute;">
    <div class="col-md-7">
      <#include "/mapDisplay.ftl">
    </div>

    <div class="col-lg-5">
      <div class="card h-100">

        <div class="card-header">
        	Building Information
        </div>

        <div class="card-block">
						<input type="hidden" value="${activeUser.id}" id="creatorId">

            <div class="row">
              <div class="col-lg-8" style="margin: 0 0 0 10px;">
                <br>
                <label>Building Name:</label>
                	<#if source?? && source != "viewBtn">
                    <input type="text" id="buildingName" placeholder="Building Name" class="form-control">
                  <#else>
                    <div><h4>${building.name}</h4></div>
                  </#if>
              </div>
            </div>

            <br>

            <div class="row">
							<div class="col-lg-11" style="margin: 0 0 0 10px;">
								<table class="table" border="1" id="coordinateTable">
									<thead class="thead-dark">
                    <tr>
                      <th>
                        <div class="row">
                          <div class="col-sm-6">
                            <h4><b>Coordinates</b></h4>
                          </div>
                          <div class="col-sm-6" align="right">
          								  <button class="btn btn-primary" style="border: 2px solid white; background-color: #212529;" id="addManualCoordinate" disabled>Add Coordinate</button>
          								</div>
                        </div>
                      </th>
                    </tr>
                  </thead>
									<tbody>
                    <tr>
                      <td>
                        <table>
                          <thead>
                            <tr> <th>Order</th> <th>Latitude</th> <th>Longitude</th> </tr>
                          </thead>
                          <tbody id="coordinateData">
                            <tr><td colspan="3" align="center"><b>No Coordinates Found</b></td></tr>
        									</tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
								</table>
							</div>
						</div>

						<br>

            <div class="row">
              <div class="col-lg-12" align="right" style="margin: 0 0 0 -10px;">
                <#if source?? && source != "viewBtn">
  								<button class="btn btn-secondary cancel">Cancel</button>
                  <button class="btn btn-primary" id="addBtn">Add</button>
                <#else>
                   <button class="btn btn-secondary" onclick="window.location='/BluePrints/mapManager'">Back</button>
                </#if>
              </div>
            </div>
        </div>
      </div>
    </div>

		<!--Modal Begin Here-->
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
						<button type="button" class="btn btn-primary" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-secondary" id="discardBtn" onClick="window.location = '/BluePrints/mapManager'">Discard</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="invalidForm">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Invalid Form</span>
					</div>
					<div class="modal-body">
						<p>Please, make sure you properly fill out the following fields:</p><br>
						<ul>
							<li>Building Name</li>
						</ul>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade success successModal" id="successAdded">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-success">
						<span class="modal-title">Success: Added Building</span>
					</div>
					<div class="modal-body">
						<p>This building was successfully added to the system.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="errorAdding">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header alert-warning">
						<span class="modal-title">Error: Adding Building</span>
					</div>
					<div class="modal-body">
						<p>This building could not be added. Please check that your fields are properly filled out and try again</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
					</div>
				</div>
			</div>
		</div>
    <div class="modal fade" id="manualCoordianteModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<span class="modal-title">Manually Add Coordinate</span>
					</div>
					<div class="modal-body">
						<div class="container col-lg-12">
              <div class="row">
                <div class="form-group col-lg-5">
                  <label for="coordOrder">Position</label>
                  <input type="text" id="coordOrder" placeholder="Enter Position" class="form-control">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-lg-8">
                  <label for="coordLat">Latitude</label>
                  <input type="text" id="coordLat" placeholder="Enter Latitude" class="form-control">
                </div>
              </div>

              <div class="row">
                <div class="form-group col-lg-8">
                  <label for="coordLon">Longitude</label>
                  <input type="text" id="coordLon" placeholder="Enter Longitude" class="form-control">
                </div>
              </div>

            </div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">close</button>
            <button type="button" class="btn btn-primary" id="addCoordinate">Add Cooridnate</button>
					</div>
				</div>
			</div>
		</div>
		<!--Modals End Here-->
</div>

<script type="text/javascript">

	$(".cancel").click(function(e) {
		e.preventDefault();
		$("#cancelModal").modal("show");
	});

	function addBuilding(buildingName, creatorId, coordinateData, successFunction, errorFunction) {
		$.ajax({
			url: "/BluePrints/mapManager/addBuilding",
			type: "POST",
			dataType: "json",
			data: {
				buildingName : buildingName,
				creatorId : creatorId,
        coordinateData: coordinateData
			},
			success: successFunction,
			error: errorFunction

		});
	}

	$("#addBtn").click(function(e) {
			e.preventDefault();


			var buildingName = $("#buildingName").val();
			var creatorId = $("#creatorId").val();

      var features = collectCoordinates(vectorLayer);
      coordinateData = convertFeaturesToJSON(features);
      console.log(coordinateData);

			var successFunction = function (response) {

				var status = response["status"];

				if(status == "ok") {
					$("#successAdded").modal("show");
				} else {
					$("#errorAdding").modal("show");
				}
			}

			var errorFunction = function(error) {
				conosle.log(error);
			}

			if(buildingName.trim() != "") {
				addBuilding(buildingName, creatorId, coordinateData, successFunction, errorFunction)
			} else {
					$("#invalidForm").modal("show");
			}

	});

	$('.successModal').on('hide.bs.modal', function (e) {
		location.reload();
	});

  /************************
   * Coordinate Section
   ************************/

   function refreshCoordinates(vectorLayer) {

 		$("#coordinateData").html("");

    var coordinateRows = "";

 		var features = collectCoordinates(vectorLayer);
 		features.forEach(function(feature) {
 			var coordinates = feature.getGeometry().getCoordinates()[0];
 			for(var i = 0; i < coordinates.length; i++) {
 				var currentLonLat = ol.proj.toLonLat(coordinates[i]);

 				var lon = currentLonLat[LONGITUDE];
 				var lat = currentLonLat[LATITUDE];

        var orderButtons = "<div class='col-sm-6'><button class='btn btn-small btn-default orderUp' onclick='orderUp(\"" + i + "\")'><i class='fas fa-chevron-up'></i></button>"
                            + "<button class='btn btn-small btn-default orderDown' onclick='orderDown(\"" + i + "\")'><i class='fas fa-chevron-down'></i></button></div>";
        var orderCell = "<td><div class='row col-lg-12'><div col-sm-6><h3>" + (i + 1) + "</h3></div>  " + orderButtons + "</div></td>";
        var lonCell = "<td>" + lon + "</td>";
        var latCell = "<td>" + lat + "</td>";
 				var coordinateRow =  "<tr>" + orderCell + latCell + lonCell + "</tr>";
        coordinateRows += coordinateRow;
 			}
 		});

    if(coordinateRows == "") {
      $("#coordinateData").html("<tr><td colspan=\"3\" align=\"center\"><b>No Coordinates Found</b></td></tr>");
    } else {
        $("#coordinateData").html(coordinateRows);
    }

 	}

 map.on('postrender', function() {
   if(typeSelect.value != "None") {
     refreshCoordinates(vectorLayer);
   }

 });




 function getNumberStyle(res) {
    var styles = [];

    styles.push(
      new ol.style.Style({
    			fill : new ol.style.Fill({
    				color : 'rgba(255,105,180, 0.2)'
    			}),
    			stroke : new ol.style.Stroke({
    				color : '#FF69B4',
    				width : 2
    			})
    		}));

    styles.push(
      new ol.style.Style({
          image: new ol.style.Circle({
            radius: 5,
            fill: new ol.style.Fill({
              color: 'black'
            })
          }),
          geometry: function(feature) {
            var coordinates = feature.getGeometry().getCoordinates()[0];
            var point =  new ol.geom.MultiPoint(coordinates);
            return point;
          }
        }));

    var coordinates = this.getGeometry().getCoordinates()[0];

    var i = 1;
    var endPoint = 1;
    coordinates.forEach(function(coord) {
      console.log(coord);
      var order = i + "";
      var flip = 1;
      styles.push(new ol.style.Style({
          geometry: new ol.geom.Point(coord),
          text: new ol.style.Text({
              text: order,
              fill: new ol.style.Fill({
                  color: "white"
              }),
              stroke : new ol.style.Stroke({
                color : '#000',
                width : 3
              }),
              offsetX: (i %2 ) ? 15 : -15
          }),
          zIndex: Number.MAX_VALUE - i
      }));

      flip *= -1;
      i++;
    });

    return styles;
  }

 vectorSource.on("addfeature", function(e) {

    var buildingFeature = e.feature;
    buildingFeature.setStyle(null);
    buildingFeature.setStyle(getNumberStyle);
    $("#addManualCoordinate").removeAttr("disabled");

    console.log(buildingFeature.getGeometry());
 });


 $("#addManualCoordinate").click(function(e) {
    e.preventDefault();

    $("#coordLon").val("");
    $("#coordLat").val("");
    $("#coordOrder").val("");
    $("#manualCoordianteModal").modal("show");
 });

 $("#addCoordinate").click(function(e) {
    e.preventDefault();

      var features = vectorLayer.getSource().getFeatures();

      features.forEach(function(buildingFeature) {

        var lon =   $("#coordLon").val();
        var lat = $("#coordLat").val();
        var position = $("#coordOrder").val();

        if(lon.trim() != "" && lat.trim() != "" && position.trim() != "") {

          lon = parseFloat(lon);
          lat = parseFloat(lat);
          position = parseInt(position);

          var newCoord = [0, 0];
          newCoord[LONGITUDE] = lon;
          newCoord[LATITUDE] = lat;

          var coord = ol.proj.fromLonLat(newCoord);
          console.log(coord);


          var coordinates = buildingFeature.getGeometry().getCoordinates()[0];

          if(position < 0){
            position = 0;
          }

          if(position <= coordinates.length - 2) {
            var firstHalf = coordinates.slice(0, position -1);

            var secondHalf = coordinates.slice(position-1, coordinates.length);

            firstHalf.push(coord);

            firstHalf.push.apply(firstHalf, secondHalf);
            coordinates = firstHalf;
          } else {
            coordinates.push(coord);
          }


          buildingFeature.getGeometry().setCoordinates([coordinates]);
          vectorLayer.getSource().removeFeature(buildingFeature);
          vectorLayer.getSource().addFeature(buildingFeature);
          refreshCoordinates(vectorLayer);
          $("#manualCoordianteModal").modal("hide");
        }



      });


 });

 function orderUp(coordinateIndex) {

    console.log(coordinateIndex + " up");

    coordinateIndex = parseInt(coordinateIndex);
    //TODO: Need to implement decreasing coordinate order.

    var features = vectorLayer.getSource().getFeatures();
    features.forEach(function(buildingFeature) {


        var coordinates = buildingFeature.getGeometry().getCoordinates()[0];

        var prevCoordinateIndex = coordinateIndex - 1;
        console.log(prevCoordinateIndex);

        if(prevCoordinateIndex >= 0) {

          var previousCoordinate = coordinates[prevCoordinateIndex];
          var currentCoordinate = coordinates[coordinateIndex];

          coordinates[prevCoordinateIndex] = currentCoordinate;
          coordinates[coordinateIndex] = previousCoordinate;

          buildingFeature.getGeometry().setCoordinates([coordinates])
          console.log(buildingFeature.getGeometry().getCoordinates());
          refreshCoordinates(vectorLayer);
        }

    });



 };

 function orderDown(coordinateIndex) {

   console.log(coordinateIndex + " down");
   coordinateIndex = parseInt(coordinateIndex);
   //TODO: Need to implement increasing coordinate order.


   var features = vectorLayer.getSource().getFeatures();

   if(features.length > 0) {
     features.forEach(function(buildingFeature) {


         var coordinates = buildingFeature.getGeometry().getCoordinates()[0];

         var nextCoordinateIndex = coordinateIndex + 1;
         console.log(nextCoordinateIndex);
         console.log(coordinateIndex);
         if(nextCoordinateIndex <= coordinates.length - 1) {

           var nextCoordinate = coordinates[nextCoordinateIndex];

           var currentCoordinate = coordinates[coordinateIndex];

           coordinates[nextCoordinateIndex] = currentCoordinate;
           coordinates[coordinateIndex] = nextCoordinate;

           buildingFeature.getGeometry().setCoordinates([coordinates]);
           console.log(buildingFeature.getGeometry().getCoordinates());
           vectorLayer.getSource().removeFeature(buildingFeature);
           vectorLayer.getSource().addFeature(buildingFeature);
           refreshCoordinates(vectorLayer);
         }

     });

   }

 }

 $('.successModal').on('hide.bs.modal', function (e) {
    window.location = "/BluePrints/mapManager";
 });


</script>


</body>

</html>
