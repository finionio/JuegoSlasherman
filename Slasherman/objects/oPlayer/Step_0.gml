//Inputs
var keyRight = keyboard_check(vk_right);
var keyLeft = keyboard_check(vk_left);
var keyJump = keyboard_check_pressed(vk_space);
var keyAttack = keyboard_check_pressed(ord("X"));
var keyDown = keyboard_check(vk_down);

//Horizontal Movement
var move = keyRight - keyLeft;

//Vertical Movement
vSpeed += grv;

//States & behaviour
switch (state)
{
	case states.idle:		
		#region
		
		//Animation
		switch(swordless)
		{
			case 0:
				if (sprite_index != sPlayerIdle) sprite_index = sPlayerIdle;
			break;
			
			case 1:
				if (sprite_index != sPlayerSwordlessBackpackIdle)sprite_index = sPlayerSwordlessBackpackIdle;
			break;
			
			case 2:
				if (sprite_index != sPlayerSwordlessIdle) sprite_index = sPlayerSwordlessIdle;
			break;
		}
		
		if (move != 0) state = states.walking;
		
		//INPUTS
		if (swordless == 0)
			{
			//Jumping
			if (keyJump && !keyDown)
			{
				hSpeed = 0;
				state = states.jumping;
			}
			//Attacking
			if (keyAttack)
			{
				hSpeed = 0;
				state = states.attacking;
			}
			//Getting off a platform
			if (keyDown && keyJump)
			{
				//Right player stand
				var _xCell = tilemap_get_cell_x_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + 1);
				var _yCell = tilemap_get_cell_y_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + 1);
				rightTile = tilemap_get(global.OneWayPlatformMap, _xCell, _yCell);
				tilemap_set(global.OneWayPlatformMap, 0, _xCell,_yCell);
			
				//Left player stand
				_xCell = tilemap_get_cell_x_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + 1);
				_yCell = tilemap_get_cell_y_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + 1);
				leftTile = tilemap_get(global.OneWayPlatformMap, _xCell, _yCell);
				tilemap_set(global.OneWayPlatformMap, 0, _xCell, _yCell);
			
				//To reactivate the tiles
				alarm[0] = 3;
			}
		
			//Occasion
			if (!IsOnGround())
			{
			frames = min(frames+1,3);
			if (frames == 3) state = states.falling;

			} else frames = 0;
		}
		
		#endregion
	break;
	
	case states.walking:
		#region
		
		//Animation
		switch (swordless)
		{
			case 0:
				if (sprite_index != sPlayerWalking)
				{
					sprite_index = sPlayerWalking;
					image_index = 0;
					image_speed = 1;
				}
			break;
			case 1:
				if (sprite_index != sPlayerSwordlessBackpackWalking)
				{
					sprite_index = sPlayerSwordlessBackpackWalking;
					image_index = 0;
					image_speed = 1;
				}
			break;
			case 2:
				if (sprite_index != sPlayerSwordlessWalking)
				{
					sprite_index = sPlayerSwordlessWalking;
					image_index = 0;
					image_speed = 1;
				}
			break;
		}
		
		//Movement
		hSpeed = walkSpd * move;
		if (hSpeed == 0) state = states.idle;
		
		if (swordless == 0)
		{
			//Inputs?
			if (keyJump)
			{
				hSpeed = 0;
				state = states.jumping;
			}
			if (keyAttack)
			{
				hSpeed = 0;
				state = states.attacking;
			}
		
			//Occasion
			if (!IsOnGround())
			{
			frames = min(frames+1, 10)
			if (frames == 10)
			{
				state = states.falling;
			}
		} else frames = 0;
		}
		
		#endregion
	break;
	
	case states.jumping:
		#region
		
		//Animation
		if (sprite_index != sPlayerJumping)
		{
			sprite_index = sPlayerJumping;
			image_speed = 0;
			image_index = 0;
		}
		
		
		//Animate jumping
		switch(image_index)
		{
			case 0:
			case 1:
				frames = min(frames+1, 5);
				
				if (frames == 5) 
				{	
					image_index++;
					frames = 0;
				}
			break;
			
			case 2: //Jump action
				switch (frames)
				{
					case 0:
						//Reset vertical movement
						vSpeed = 0;
						vSpeedF = 0;
						
						//Jump action
						vSpeed += jumpHeight;
						frames++;
					break;
					
					case 1:
						hSpeed = walkSpd * move;
						
						if(vSpeed > 0)
						{
							image_index++;
							frames = 0;
							state = states.falling;
						}
					break;
				}
			break;
		}
		
		#endregion
	break;
	
	case states.falling:
		#region
		
		//Animation
		if (sprite_index != sPlayerJumping)
		{
			sprite_index = sPlayerJumping;
			image_index = 3;
			image_speed = 0;
			frames = 0;
		}
		
		switch(image_index)
		{
			case 3:
				hSpeed = walkSpd * move;
				
				if (IsOnGround())
				{
					image_index++;
					hSpeed = 0;
				}
			break;
			
			case 4: 
				frames = min(frames+1, 5);
				
				if (frames == 5)
				{
					image_index++;
					frames = 0;
				}
			break;
			
			case 5:
				frames = min(frames+1, 5);
				
				if (frames == 5)
				{
					frames = 0;
					state = states.idle;
					image_speed = 1;
				}
			break;
		}
		
		#endregion
	break;
	
	case states.attacking:
		#region
			
			//Animation
			if (sprite_index != sPlayerAttacking)
			{	
				sprite_index = sPlayerAttacking;
				image_index = 0;
				image_speed = 1;
				
				//Create Hitbox
				with (instance_create_layer(x,y,"Instances", oHitbox))
				{
					creator = other.id;
					sprite_index = sPlayerHitbox;
					image_xscale = other.image_xscale;
				}
			}
			
		
		#endregion
	break;
	
	case states.damaged:
		#region 
		
		if (sprite_index != sPlayerDamaged)
		{
			sprite_index = sPlayerDamaged;
			image_index = 0;
			image_speed = 1;
			
			//damage
			life -= damageRecieved;
			damageRecieved = 0;
			
			//Dead?
			if (life <= 0 && global.debug == false)
			{
				state = states.dead;
				exit;
			}
			
			//Knockback jump
			vSpeed -= 3;
		}
		
		if (!IsOnGround())hSpeed = knockback * image_xscale;
		else hSpeed = 0;
		
		#endregion
	break;
	
	case states.dead:
		#region
		if (sprite_index != sPlayerDead)
		{
			sprite_index = sPlayerDead;
			image_index = 0;
			image_speed = 1;
			
			hSpeed = 0;
		}
		
		//Animation end actions...
		if (alarm[2] == -1) alarm[2] = room_speed * 5;
		#endregion
	break;
	
	case states.still:
		switch(swordless)
		{
			case 0:
				if (sprite_index != sPlayerIdle) sprite_index = sPlayerIdle;
			break;
			
			case 1:
				if (sprite_index != sPlayerSwordlessBackpackIdle)sprite_index = sPlayerSwordlessBackpackIdle;
			break;
			
			case 2:
				if (sprite_index != sPlayerSwordlessIdle) sprite_index = sPlayerSwordlessIdle;
			break;
		}
		
		hSpeed = 0;
	break;
	
	case states.usingStairs:
		hSpeed = 0;
	break;
	
	case states.cutscene:
		hSpeed = 0;
		//Do nothing
	break;
}

//Flip xscale
if (state != states.damaged)	
{
	if (hSpeed < 0) image_xscale = 1;
	if (hSpeed > 0) image_xscale = -1;
}

//Purge decimals in speed
#region 
//hSpeedFinal = hSpeed + hSpeedF;
//hSpeedF = hSpeedFinal - floor(abs(hSpeedFinal))*sign(hSpeedFinal);
//hSpeedFinal -= hSpeedF;
hSpeedFinal = hSpeed;

vSpeedFinal = vSpeed + vSpeedF;
vSpeedF = vSpeedFinal - floor(abs(vSpeedFinal))*sign(vSpeedFinal);
vSpeedFinal -= vSpeedF;
#endregion

//Collisions
TileCollisionCheck();

//vSpeed limits
vSpeed = clamp(vSpeed, -6,6);

x += hSpeedFinal;
y += vSpeedFinal;
