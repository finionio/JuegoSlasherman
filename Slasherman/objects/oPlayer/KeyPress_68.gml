/// @desc DEBUG toggle debug var
global.debug = !global.debug;

if (global.debug)
{
	layer_set_visible("Collision", true);
	layer_set_visible("OneWayPlatform", true);
}
else
{
	layer_set_visible("Collision", false);
	layer_set_visible("OneWayPlatform", false);
}