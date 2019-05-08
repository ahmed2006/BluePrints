

	<div class= "row">
   <div class="col-lg-6 col-lg-offset-1">
      <form class="form-inline">
         <label>Choose Action:</label>
         <select id="type">
            <option value="None">Navigate</option>
						<#if source?? && source != "viewBtn">
	            <option value="Polygon">Draw</option>
						</#if>
         </select>
      </form>
   </div>

  <div class="col-lg-5">
      <div align="right">
        <button class="btn btn-primary"id="helpBtn">help</button>
      </div>
  </div>
</div>


<br>

<div class="row">
   <div class="col-lg-11 col-lg-offset-1" >
      <div id="map" class="map" style="border: 3px solid black;">
         <div id="popup"></div>
      </div>
   </div>
</div>

<div class="modal fade" id="helpInfo">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <span class="modal-title">Instructions</span>
          </div>
          <div class="modal-body">
            To navigate around the map without drawing, simply select the nagivate option in the drop down.
            click and drag the cursor around the map to move. If needed to soom, use the mouse wheel.
            <br>
            To draw on the map select the draw option in the drop down. Once selected you can create lines but clicking
            and holding the cursor and dragging it accross the map. Once shape is created give the building a name and select add.
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" id="closeBtnHelp" data-dismiss="modal">close</button>
          </div>
      </div>
    </div>
</div>

<script type="text/javascript">
  $("#helpBtn").click(function(e) {
    e.preventDefault();
    $("#helpInfo").modal("show");
  });

   $("#closeBtnHelp").click(function(e) {
    e.preventDefault();
    $("#helpInfo").modal("close");
  });
</script>

<script type="text/javascript" src= "/BluePrints/js/openLayersMapFunctions.js"></script>
<script type="text/javascript" src= "/BluePrints/js/mapCore.js"></script>
