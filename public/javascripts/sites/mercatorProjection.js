// Create a spherical mercator projection, adding in FromDivPixelToSphericalMercator method.  
// Original code from Google Maps API v 3 List/user: KakaduDreamer and
// http://code.google.com/apis/maps/documentation/v3/examples/map-coordinates.html

var MERCATOR_RANGE = 256;

function bound(value, opt_min, opt_max) {
  if (opt_min != null) value = Math.max(value, opt_min);
  if (opt_max != null) value = Math.min(value, opt_max);
  return value;
}
 
function degreesToRadians(deg) {
  return deg * (Math.PI / 180);
}
 
function radiansToDegrees(rad) {
  return rad / (Math.PI / 180);
}
 
function MercatorProjection() {
  this.pixelOrigin_ = new google.maps.Point(
      MERCATOR_RANGE / 2, MERCATOR_RANGE / 2);
  this.pixelsPerLonDegree_ = MERCATOR_RANGE / 360;
  this.pixelsPerLonRadian_ = MERCATOR_RANGE / (2 * Math.PI);
};
 
MercatorProjection.prototype.fromLatLngToPoint = function(latLng, opt_point) {
  var me = this;
 
  var point = opt_point || new google.maps.Point(0, 0);
 
  var origin = me.pixelOrigin_;
  point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_;
  // NOTE(appleton): Truncating to 0.9999 effectively limits latitude to
  // 89.189.  This is about a third of a tile past the edge of the world tile.
  var siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999, 0.9999);
  point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) * -me.pixelsPerLonRadian_;
  return point;
};
 
MercatorProjection.prototype.fromDivPixelToLatLng = function(pixel, zoom) {
  var me = this;
  
  var origin = me.pixelOrigin_;
  var scale = Math.pow(2, zoom);
  var lng = (pixel.x / scale - origin.x) / me.pixelsPerLonDegree_;
  var latRadians = (pixel.y / scale - origin.y) / -me.pixelsPerLonRadian_;
  var lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2);
  return new google.maps.LatLng(lat, lng);
};

MercatorProjection.prototype.fromDivPixelToSphericalMercator = function(pixel, zoom) {
  var me = this;
  var coord = me.fromDivPixelToLatLng(pixel, zoom);
  
  var r= 6378137.0;
  var x = r* degreesToRadians(coord.lng());
  var latRad = degreesToRadians(coord.lat());
  var y = (r/2) * Math.log((1+Math.sin(latRad))/ (1-Math.sin(latRad)));
 
  return new google.maps.Point(x,y);
};