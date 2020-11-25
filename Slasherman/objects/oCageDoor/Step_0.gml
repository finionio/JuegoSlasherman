/// @desc

switch (state)
{
	case states.idle:
		if (place_meeting(x,y, oHitbox))
		{	
			life--;
			if (life <= 0) state = states.dead;
			else state = states.damaged;
		}
	break;
	
	case states.damaged:
		#region
		frames = min(frames+1, room_speed / 3);
		
		x = originalx + irandom_range(-1*magnitude,magnitude);
		
		if (frames == room_speed /3)
		{
			state = states.idle;
			frames = 0;
			x = originalx;
		}
		#endregion
	break;
	
	case states.dead:
		if (!layer_sequence_exists("Instances", sequence))
		{
			sequence = layer_sequence_create("Instances", x,y, sqCageDoor);
			seqElement = layer_sequence_get_instance(sequence);
			sequence_instance_override_object(seqElement, oCageDoor, self);
			
			//Removing collision tiles
			tilemap_set(global.collisionMap, 0, 11,16);
			tilemap_set(global.collisionMap, 0, 11,17);
			
		}
		
		
		//Stay in the last frame
		if (layer_sequence_is_finished(sequence)) layer_sequence_pause(sequence);
	break;
}