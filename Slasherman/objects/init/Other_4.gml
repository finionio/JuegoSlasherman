/// @desc

//Set collision info
var _mapId = layer_get_id("Collision");
global.collisionMap = layer_tilemap_get_id(_mapId);
_mapId = layer_get_id("OneWayPlatform");
global.OneWayPlatformMap = layer_tilemap_get_id(_mapId);