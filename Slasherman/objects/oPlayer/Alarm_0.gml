/// @desc Reactivating the platform tiles
var _xCell = tilemap_get_cell_x_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + 1);
var _yCell = tilemap_get_cell_y_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + 1);
if (rightTile != 0)
{
	tilemap_set(global.OneWayPlatformMap, rightTile, _xCell, _yCell);
}

_xCell = tilemap_get_cell_x_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + 1);
_yCell = tilemap_get_cell_y_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + 1);
if (leftTile != 0)
{
	tilemap_set(global.OneWayPlatformMap, leftTile, _xCell, _yCell);
}