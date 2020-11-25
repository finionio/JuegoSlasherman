/// @desc
if (collision && place_meeting(x,y, oPlayer))
{
	StartTransition(transition.black);
	collision = false;
}

/////////DEBUG
if global.debug visible = true;
else visible = false;