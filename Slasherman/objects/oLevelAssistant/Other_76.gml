/// @desc
if (event_data[? "event_type"] == "sequence event")
{
	switch (event_data[? "message"])
	{
		case "STOP":
			//Stop sequence
			layer_sequence_pause(event_data[? "element_id"]);
			
			//Move WARP where player is
			var _warp = instance_find(oWarp, 0);
			_warp.x = oPlayer.x;
			_warp.y = oPlayer.y;
			cutscene = false;
			
		break;
	}
}
