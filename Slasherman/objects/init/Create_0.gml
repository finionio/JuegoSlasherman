 /// @desc
//Game settings
display_set_gui_size(720,360);

//Global vars
global.debug = false;

//Instance Creations
if (!instance_exists(oCamera)) instance_create_layer(0,0, "Instances", oCamera);
if (!instance_exists(oLevelAssistant)) instance_create_layer(0,0, "Instances", oLevelAssistant);

//STATES
//Global states
enum states
{
	idle,
	walking,
	jumping,
	falling,
	attacking,
	damaged,
	dead,
	still,
	usingStairs,
	cutscene
}
//Enemy states
enum enemyStates
{
	alert,
	chasing,
	stepping
}

//Set collision info
//var _mapId = layer_get_id("Collision");
//global.collisionMap = layer_tilemap_get_id(_mapId);
//_mapId = layer_get_id("OneWayPlatform");
//global.OneWayPlatformMap = layer_tilemap_get_id(_mapId);

with (instance_create_layer(0,0,"Instances", oTransition))
{	
	a = 1;
	type = transition.init;
}
