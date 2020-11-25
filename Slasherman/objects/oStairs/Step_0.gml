/// @desc

/////////DEBUG
if global.debug visible = true;
else visible = false;

//////////////
if (place_meeting(x,y,oPlayer) && keyboard_check_pressed(vk_up) && (oPlayer.state == states.idle || oPlayer.state = states.walking))
{
	oPlayer.state = states.usingStairs;
	oPlayer.x = x;
	oPlayer.image_index = 0;
	
	switch (dir)
	{
		case 0: //Down
			oPlayer.sprite_index = sPlayerGoingDownFromTop;
		break;
		
		case 1: //Up
			oPlayer.sprite_index = sPlayerGoingUpFromBottom;
		break;
	}
	
	StartTransition(type);
}