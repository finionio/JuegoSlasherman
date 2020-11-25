/// @desc

var frame = 1/40;

switch (type)
{
	case transition.init:
		a = max (a-frame,0);
		draw_sprite_ext(sPixel, 0, 0,0,GUI_WIDTH, GUI_HEIGHT, 0, c_black, a);
		
		if (a == 0) instance_destroy();
	break;
	
	case transition.restart:
		a = min (a+frame, 1);
		draw_sprite_ext(sPixel, 0, 0,0,GUI_WIDTH, GUI_HEIGHT, 0, c_black, a);
		
		if (a == 1) game_restart();
	break;
	
	default:
		//alpha progress
		if (fadeIn)	a = min(a + frame, 1 + (10*frame));
		else a = max(a - frame, 0);
	
		//Changing room
		if (a == 1 + (10*frame))
		{
			fadeIn = false;
			room_goto(targetRoom);
			oPlayer.x = targetX;
			oPlayer.y = targetY;
			oPlayer.state = states.idle;
			oCamera.target = oPlayer;
		}
		//Destroy de instance
		if (a == 0) instance_destroy();

		switch (type)
		{
			case transition.black:
				draw_sprite_ext(sPixel, 0, 0,0,GUI_WIDTH, GUI_HEIGHT, 0, c_black, a);
			break;
	
			case transition.white:
				draw_sprite_ext(sPixel, 0, 0,0,GUI_WIDTH, GUI_HEIGHT, 0, c_white, a);
			break;
		}
	break;
}