var LONGITUDE = 0;
var LATITUDE = 1;

function getVectorLayer(vectorSource) {
	return new ol.layer.Vector({
		source : vectorSource,
		style : new ol.style.Style({
			fill : new ol.style.Fill({
				color : 'rgba(255,105,180, 0.2)'
			}),
			stroke : new ol.style.Stroke({
				color : '#FF69B4',
				width : 2
			}),
			image : new ol.style.Circle({
				radius : 7,
				fill : new ol.style.Fill({
					color : '#FF69B4'
				})
			})
		})
	});
}

function getStyle() {
	return new ol.style.Style({
		image : new ol.style.Icon( /** @type {olx.style.IconOptions} */
		({
			anchor : [ 0.5, 46 ],
			anchorXUnits : 'fraction',
			anchorYUnits : 'pixels',
			src : 'https://openlayers.org/en/v4.6.5/examples/data/icon.png'
		}))
	});
}


function getRaster() {
	return new ol.layer.Tile({
		source : new ol.source.OSM()
	});
}

function getMap(raster, vectorLayer, floorLayer) {
	return new ol.Map({
		target : 'map',
		layers : [ raster, vectorLayer, floorLayer ],
		view : new ol.View({
			center : ol.proj.fromLonLat([ -75.879105, 41.249065 ]),
			rotation: 0.639206,
			zoom : 18
		})
	});
}


/**
 * This function adds the ability to drawS.
 */
function addInteractions(vectorSource, map, draw, snap) {
	var modify = new ol.interaction.Modify({
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
}

/**
 * Creates a control button that can be added to the
 * map.
 *
 * @param labael The text that will be displayed on the button.
 * @param tipTool  The text displayed when hovering over the button.
 * @param action  The function the button will call when pressed.
 * @param x The x-axis for the control on the map.
 * @param y The y-axis for the control on the map.
 * @return the newly create control that can be added to the map.
 */
function createControl(label, tipTool, action, x, y) {
	var button = document.createElement('div');
	button.innerHTML = '<button class="ol-rotate-reset-river" type="button" title="' + tipTool + '">' + label + '</button>';
	button.className = 'ol-unselectable ol-control';
	button.style.position="absolute";
	button.style.width="24px";
	button.style.top =  y + "px";
	button.style.left = x + "px";

	button.addEventListener("click", action, false);

	var control = new ol.control.Control({
	    element: button
	});

	return control;
}

function collectCoordinates(vectorLayer) {
	var features = vectorLayer.getSource().getFeatures();
	return features;
}

function addOverlay(){
	return new ol.Overlay({
		element : element,
		positioning : 'bottom-center',
		stopEvent : false,
		offset : [ 0, -50 ]
	});
}

function rehydrateMap(coordinateData, vectorLayer) {

	var geoJSON = new ol.format.GeoJSON;
	var coordinateJSON = JSON.parse(coordinateData);
	var features = geoJSON.readFeatures(coordinateJSON);

	vectorLayer.getSource().clear();
	vectorLayer.getSource().addFeatures(features);

}

var geoJSON = new ol.format.GeoJSON;

function convertJSONtoFeature(coordinateData) {

	var coordinateJSON = coordinateData.replace(/\\/g, "");
	coordinateJSON = coordinateJSON.replace(/^"/g, "");
	coordinateJSON = coordinateJSON.replace(/"$/g, "");
	var coordinateJSON = JSON.parse(coordinateData);
	var feature = geoJSON.readFeature(coordinateJSON);

	feature.setStyle(defaultRoomStyle);

	return feature;
}

function convertJSONtoFeatures(coordinateData) {

	var coordinateJSON = coordinateData.replace(/\\/g, "");
	coordinateJSON = coordinateJSON.replace(/^"/g, "");
	coordinateJSON = coordinateJSON.replace(/"$/g, "");
	var coordinateJSON = JSON.parse(coordinateData);
	var features = geoJSON.readFeatures(coordinateJSON);

	return features;
}

function convertFeaturesToJSON(features) {

	var coordinateData = geoJSON.writeFeatures(features);
	coordinateData = JSON.stringify(coordinateData);

	return coordinateData;
}

function convertFeatureToJSON(feature) {

	var coordinateData = geoJSON.writeFeature(feature);
	coordinateData = JSON.stringify(coordinateData);

	return coordinateData;
}

function getRoomFromLayer(roomId, layer, resultFunction) {
	layer.getSource().getFeatures().forEach(function(feature) {
			if(feature.get("roomId") == roomId) {
				resultFunction(feature);
			}
	});

}
