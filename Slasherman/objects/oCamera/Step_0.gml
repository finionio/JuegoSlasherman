switch (state)	
{
	case cameraStates.follow:	

		if (instance_exists(target))
		{
			//target = oPlayer;
	
			if (prevTarget != target)
			{
				cameraSpeed += 0.5;
				x = Approach(x,target.x,cameraSpeed);
				y = Approach(y,target.y,cameraSpeed);
	
				if (x == target.x && y == target.y) 
				{	
					cameraSpeed = 0.5;
					prevTarget = target;
				}
			}
			else
			{
				x = target.x;
				y = target.y;
			}
		}

		x = clamp(x, cameraWidthHalf, room_width - cameraWidthHalf);
		y = clamp(y, cameraHeightHalf, room_height - cameraHeightHalf);

		camera_set_view_pos(camera, x - cameraWidthHalf, y - cameraHeightHalf);
	break;
	
	case cameraStates.free:
		//Do nothing
		camera_set_view_pos(camera,x - cameraWidthHalf,y - cameraHeightHalf);
	break;
}