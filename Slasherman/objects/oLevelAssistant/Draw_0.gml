/// @desc

switch (room)
{
	case rBegin:
	#region Show tutorial keys
	if (tutorial)
	{
		depth = oPlayer.depth + 1;
		a = min(a+increment,1);
		draw_set_alpha(a);
		
		//Sub-image control
		animationFrames = min (animationFrames+(spriteSpeed/room_speed), 1);
		if (animationFrames == 1)
		{
			if (subImg + 1 == subImages) subImg = 0;
			else subImg++;
			animationFrames = 0;
		}
		
		//Press ArrowKeys
		draw_sprite(sPressArrowKeys,subImg,125,166);
		//Press C
		draw_sprite(sPressC, subImg, 322,160);
		
		draw_set_alpha(1);
	}
	else { a = 0; depth = oPlayer.depth - 1; } 
	#endregion
		
	#region CUTSCENE orc
	switch(step)
	{
		case 0: 
			if (oPlayer.x >= 970 && oPlayer.x <= 1039)
			{
				cutscene = true;
				tutorial = false;
				with (oPlayer)
				{
					state  = states.cutscene;
					sprite_index = sPlayerSwordlessBackpackWalking;
					image_speed = 1;
					x += walkSpd;
				}	
				
				
			}
			
			if (oPlayer.x >= 1039) 
			{
				with (oPlayer)
				{
					sprite_index = sPlayerSwordlessBackpackIdle;
					image_speed = 1;
				}
				step++;
				oCamera.state = cameraStates.free;
			}
		break;
		
		case 1:
			//Wait a bit before screenshakes
			var _frames = room_speed * 1;
			frames = min(frames+1, _frames);
			
			//Do screenshakes
			if (frames == _frames && ScreenShake(2,1,30,0.5))
			{
				step++;	
				frames = 0;
			}
		break;
		
		case 2:
			_frames = room_speed * 1;
			
			//Draw alert sprite
			draw_sprite(sAlert, 0, oPlayer.x + 8, oPlayer.bbox_top);
			
			if (frames == _frames){ step++; frames = 0; }
			else frames = min(frames+1, _frames);
		break;
		
		case 3:
			//Wait a bit before moving the camera
			_frames = room_speed * 0.5;
			if (frames == _frames){ step++; frames = 0; }
			else frames = min(frames+1, _frames);
		break;
		
		case 4:
			//Moving the camera up
			var _targetX = 1071;
			var _targetY  = 111;
			
			with (oCamera)
			{
				x = Approach(x, _targetX, 0.4);
				y = Approach(y, _targetY, 0.4);
				
				if (x == _targetX && y == _targetY) other.step++;
			}
		break;
		
		case 5:
			//Boss walking
			with (oBoss)
			{
				state = states.walking;
				walkSpd = -0.3;
				hSpeed = walkSpd;
				
				//Screenshake
				//ScreenShake(8, 1, 0, 0.5);
				
				if (ScreenShake(9, 1, 0, 0.5) && x <= 1117)
				{
					hSpeed = 0;
					walkSpd = 0;
					state = states.idle;
					other.step++;
				}
			}
		break;
		
		case 6:
			//Waiting a bit before boss stepping
			_frames = room_speed * 1;
			if (frames == _frames) { step++; frames = 0; }
			else frames = min(frames+1, _frames);
		break;
		
		case 7:
			//Stepping and rubmbling
			oBoss.state = enemyStates.stepping;
			
			//Wait to move camera
			_frames = room_speed * 4;
			if (frames == _frames) { step++; frames = 0; }
			else frames = min(frames+1, _frames);
		break;
		
		case 8:
			//Moving camera to the player
			_targetX = 1038;
			_targetY = 184;
			with (oCamera)
			{
				originalX = Approach(originalX,_targetX, 0.4);
				originalY = Approach(originalY,_targetY, 0.4);
				
				if (originalX == _targetX && originalY == _targetY) {other.step++; }
			}
		break;
		
		case 9:
			oBoss.state = states.idle;
			oPlayer.swordless = 2;
			var _decorationMap = layer_tilemap_get_id("Decoration");
			
			//Remove the ground from the player
			tilemap_set(global.collisionMap, 0, 63,12);
			tilemap_set(global.collisionMap, 0, 64,12);
			tilemap_set(global.collisionMap, 0, 65,12);
			tilemap_set(global.collisionMap, 0, 66,12);
			tilemap_set(_decorationMap, 0, 63, 12); 
			tilemap_set(_decorationMap, 0, 64, 12);
			tilemap_set(_decorationMap, 0, 65, 12);
			tilemap_set(_decorationMap, 0, 66, 12);
			tilemap_set(_decorationMap, 0, 63, 13); 
			tilemap_set(_decorationMap, 0, 64, 13);
			tilemap_set(_decorationMap, 0, 65, 13);
			tilemap_set(_decorationMap, 0, 66, 13);
			
			step++;
		break;
		
		case 10:
			//Wait and play the backpack animation/sequence
			layer_sequence_create("Instances", CAMERA_X, CAMERA_Y, sqBackpack);
			//Readjust the camera
			oCamera.state = cameraStates.follow;
			oCamera.target = noone;
			step++;
		break;
	}
	#endregion
	break;
	
	case rTutorial:
	#region Show tutorial keys
	depth = oPlayer.depth + 1;
	if (tutorial)
	{
		a = min(a+increment,1);
		draw_set_alpha(a);
		
		//Sub-image control
		animationFrames = min (animationFrames+(spriteSpeed/room_speed), 1);
		if (animationFrames == 1)
		{
			if (subImg + 1 == subImages) subImg = 0;
			else subImg++;
			animationFrames = 0;
		}
		
		//Press X
		draw_sprite(sPressX,subImg,128,256);
		//Press Space
		draw_sprite(sPressSpace,subImg,352,256);
		//Press Space + Down
		draw_sprite(sPressCrouch,subImg,511,208);
		//Press Up 
		draw_sprite(sPressUp,subImg,710,204);
		
		draw_set_alpha(1);
	}
	else a = 0; 
	#endregion
	break;
}

//CUTSCENES
#region BLACKBARS
if (cutscene)
{
	blackbarsHeight = min(blackbarsHeight + blackbarsSpeed, blackbarsHeightMax);
}
else
{
	blackbarsHeight = max(blackbarsHeight - blackbarsSpeed, 0);
}
draw_sprite_ext(sPixel,0,CAMERA_X,CAMERA_Y,CAMERA_WIDTH,blackbarsHeight,0,c_black,1);
draw_sprite_ext(sPixel,0,CAMERA_X,CAMERA_Y+CAMERA_HEIGHT-blackbarsHeight,CAMERA_WIDTH,blackbarsHeight,0,c_black,1);
#endregion