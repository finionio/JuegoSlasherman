/// @desc
if (place_meeting(x,y, oPlayer))
{
	//Snap to position and play animation
	oPlayer.x = x;
	oPlayer.y = y;
	oPlayer.image_index = 0;
	oPlayer.state = states.usingStairs;
	
	switch (dir)
	{
		case 0: //down
			oPlayer.sprite_index = sPlayerGoingUpFromTop;
		break;
		
		case 1: //up
			oPlayer.sprite_index = sPlayerGoingDownFromBottom;
		break;
	}
	
}