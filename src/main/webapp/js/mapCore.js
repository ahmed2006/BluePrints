


var vectorSource = new ol.source.Vector();

var vectorLayer =  getVectorLayer(vectorSource);

var floorSource = new ol.source.Vector();
var floorLayer = getVectorLayer(floorSource);

var iconStyle = getStyle();

var raster = getRaster();

var map = getMap(raster, vectorLayer, floorLayer);

var draw, snap, modify; // global so we can remove them later

var typeSelect = document.getElementById('type');

var floorSelector = new ol.interaction.Select({
	condition: ol.events.condition.click,
	layers: function(layer) {
		return (layer == floorLayer);
	}
});

var defaultRoomStyle = new ol.style.Style({
	stroke: new ol.style.Stroke({
		color: 'black',
		width: 2,
		zIndex: 0
	})
});

var floorTransform = new ol.interaction.Transform (
	{
	layers: [floorLayer],
	translateFeature: true,
	scale: true,
	rotate: true,
	keepAspectRatio: undefined,
	translate: true,
	stretch: false,

});


var extentGenerator = new ol.interaction.Extent();


/**
 * Handle change event, difficult to move function oustide of this file.
 */
typeSelect.onchange = function() {
	if (typeSelect.value != "None") {
		//addInteractions(vectorSource, map, draw, snap);
		 modify = new ol.interaction.Modify({
			source : vectorSource
		});

		map.addInteraction(modify);

		draw = new ol.interaction.Draw({
			source : vectorSource,
			type : typeSelect.value
		});

		map.addInteraction(draw);
		snap = new ol.interaction.Snap({
			source : vectorSource
		});
		map.addInteraction(snap);

	} else {
		map.removeInteraction(draw);
		map.removeInteraction(snap);
		map.removeInteraction(modify);
	}
};

var element = document.getElementById('popup');

var popup = addOverlay();

map.addOverlay(popup);

$(element).attr("show", false);

/**
 * This method houses the logic of what should mapped on the map.
 */
map.on('click', function(evt) {

	var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature) {
		return feature;
	});

	if (feature && raster.getVisible()) {
		if (typeSelect.value == "None") {
			var coordinates = feature.getGeometry().getCoordinates();
			var transformedCords = ol.proj.toLonLat(coordinates);
			popup.setPosition(coordinates);
			$(element).popover(
					{
						'placement' : 'top',
						'html' : true,
						'content' : "Lon: " + transformedCords[0] + "\n"
								+ "Lat: " + transformedCords[1]
					});
			$(element).attr("show", true);
			$(element).popover('show');
		}

	} else {
		if (typeSelect.value == "None") {
			if ($(element).attr("show") == "true") {
				$(element).attr("show", false);
				$(element).popover('destroy');
			}
		}
	}
});


/*
 * Creating Rotate to River Street Control button.
 */
function rotateToRiver() {
		map.getView().setRotation(0.639206);
}

var rotateRiverControl = createControl("R", "Rotate to River Street", rotateToRiver, 9, 70);
map.addControl(rotateRiverControl);


/*
 * Creating Control reset zoom to building shape.
 */
function resetZoom() {
	map.getView().fit(vectorLayer.getSource().getExtent(), {size:map.getSize(), constrainResolution: false});
}

function drawSquare(resultFunction = null) {

	draw = new ol.interaction.Draw({
            source: floorSource,
            type: "Circle",
            geometryFunction: ol.interaction.Draw.createRegularPolygon(4)
          });

	draw.on("drawend", function(e) {

		map.removeInteraction(draw);

		var roomFeature = e.feature;
		roomFeature.setStyle(defaultRoomStyle);
		if(resultFunction != null) {
				resultFunction(roomFeature);
		}
	})

  map.addInteraction(draw);

}

function getSelectedRoomFeatures() {
	return floorSelector.getFeatures();
}

var resetZoomControl = createControl("Z", "Reset Zoom", resetZoom, 9, 100);
map.addControl(resetZoomControl);
