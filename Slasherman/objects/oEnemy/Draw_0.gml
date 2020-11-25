/// @desc 

////////////DEBUG
//Life
event_inherited();

if (global.debug)
{
	//Alert vision
	if (!seeing) draw_rectangle(x + (alertVision*(image_xscale*-1)), bbox_top, x, bbox_bottom, true);
	if (seeing && oPlayer.state != states.dead)
	{
		//AttackRange
		draw_rectangle(oPlayer.bbox_left - attackRange, oPlayer.bbox_top, oPlayer.bbox_right + 
						attackRange, oPlayer.bbox_bottom, true);
	
		//escapeVision
		draw_rectangle(x, bbox_top, x + (escapeVision*image_xscale*-1), bbox_bottom, true);
	}
}

////////////////


//Alert states
if (alert)
{
	draw_sprite(sAlert, 0, x, bbox_top);
}