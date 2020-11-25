
function Approach(from, to, spd){
/// Approach(a, b, amount)
/// @arg from
/// @arg to
/// @arg speed
// Moves "a" towards "b" by "amount" and returns the result
// Nice bcause it will not overshoot "b", and works in both directions
// Examples:
//      speed = Approach(speed, max_speed, acceleration);
//      hp = Approach(hp, 0, damage_amount);
//      hp = Approach(hp, max_hp, heal_amount);
//      x = Approach(x, target_x, move_speed);
//      y = Approach(y, target_y, move_speed);
argument0 = from;
argument1 = to;
argument2 = spd;

if (argument0 < argument1)
{
    argument0 += argument2;
    if (argument0 > argument1)
        return argument1;
}
else
{
    argument0 -= argument2;
    if (argument0 < argument1)
        return argument1;
}
return argument0;
}
	
function DrawSpriteAnimated(_x,_y,_sprite){
	///@desc This function is used for drawing a sprite with its 
	///		 animation, without having to use and object
	///@arg x The x position
	///@arg y The y position
	///@arg sprite The sprite to draw
	
	//Instance vars
	//frames, subImg
	
	var spd = sprite_get_speed(_sprite);
	var subImages = sprite_get_number(_sprite);
	
	frames = min (frames+(spd/room_speed), 1);
	
	if (frames == 1)
	{
		if (subImg + 1 == subImages) subImg = 0;
		else subImg++;
		frames = 0;
	}
	
	draw_sprite(_sprite, subImg, _x, _y);
}
	
function StartTransition(_type){
	/// @desc	This function creates a transition instance and passes
	///			all parameters to it
	///
	/// @arg	_type	transition.black or transition.white
	
	with (instance_create_layer(0,0, "Instances", oTransition))
	{
		type = _type;
		targetRoom = other.targetRoom;
		targetX = other.targetX;
		targetY = other.targetY;
	}
	
	oCamera.target = noone;
}