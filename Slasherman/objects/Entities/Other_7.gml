
//For all Entities
switch(state)
{
	case states.attacking:
	case states.damaged:
		state = states.idle;
	break;
	
	case states.dead:
		if (alarm[1] == -1)
		{
			alarm[1] = room_speed * 30;
			image_speed = 0;
			image_index = image_number - 1;
		}
	break;
	
	case states.usingStairs:
		//image_index = image_number - 1;
		//image_speed = 0;
		state = states.idle;
	break;
}