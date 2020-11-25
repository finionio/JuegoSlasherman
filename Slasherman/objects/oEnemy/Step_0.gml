/// @desc

//Facing player (image_xscale)
if (state != states.attacking && state != states.damaged && state != states.dead)
{
	if (instance_exists(oPlayer))
	{
		if (x < oPlayer.x) image_xscale = -1;
		else image_xscale = 1;
	}
}

//Gravity
vSpeed += grv;

//States and Behaviour
switch(state)
{
	case states.idle:
		#region
		
		if (sprite_index != idleSprite)
		{
			sprite_index = idleSprite;
			image_index = 0;
			image_speed = 1;
			
			hSpeed = 0;
		}
	
		//Enemy being Alert collision
		if (!seeing && collision_rectangle(x + (alertVision*(image_xscale*-1)), bbox_top, x, bbox_bottom, oPlayer, false, true))
		{
			
			//Alarm for changing to chase state
			if (alarm[0] == -1) alarm[0] = coolDown;
	
			alert = true;			
		}
		else 
		{
			//if the enemy has already been seen, wait to chase again
			//Cooldown is used here
			if (seeing)
			{
				if (alarm[0] == -1) alarm[0] = coolDown;
			}
			else
			{
				alert = false;
				alarm[0] = -1;
			}
		}
		
	
		#endregion
	break;
	
	case states.damaged:
		#region
		
		if (sprite_index != damagedSprite)
		{
			sprite_index = damagedSprite;
			image_index = 0;
			image_speed = 1;
			
			//Damage
			life -= damageRecieved;
			damageRecieved = 0;
			
			//Dead?
			if (life <= 0 && global.debug == false)
			{	
				state = states.dead;
				alarm[0] = -1;
				exit;
			}
			
			//Knockback jump
			vSpeed -= knockbackJump;
		}
		
		//Reset Chasing alarm if seen
		if (seeing) alarm[0] = room_speed / 2;
		
		//Knockback
		if (!IsOnGround())hSpeed = knockback * image_xscale;
		else hSpeed = 0;
		
		#endregion
	break;
	
	case enemyStates.chasing:
		#region
		
		if (sprite_index != walkingSprite)
		{
			sprite_index = walkingSprite;
			image_index = 0;
			image_speed = 1;
		}
		
		//If player sight lost
		if (!collision_rectangle(x, bbox_top, x + (escapeVision*image_xscale*-1), bbox_bottom, oPlayer, false,true))
		{
			state = states.idle;
			seeing = false;
			//show_message("Sight lost");
		}
		
		//Movement
		hSpeed = walkSpd * (image_xscale*-1);
		
		//Attack range
		if (collision_rectangle(oPlayer.bbox_left - attackRange, oPlayer.bbox_top, oPlayer.bbox_right + 
			attackRange, oPlayer.bbox_bottom, self, false, false))
		{
				state = states.attacking;
				hSpeed = 0; 
		}
			
		#endregion
	break;
	
	case states.attacking:
		#region
		
		if (sprite_index != attackingSprite)
		{
			sprite_index = attackingSprite;
			image_index = 0;
			image_speed = 1;
			hSpeed = 0;
			
			with (instance_create_layer(x,y,"Instances", oHitbox))
			{
				creator = other.id;
				sprite_index = other.hitboxSprite;
				image_xscale = other.image_xscale;
			}
		}
		
		#region Slime attack
		if (self.object_index == oSlime)
		{
			switch(image_index)
			{
				case 7: //Jumping
					
					if (image_speed != 0)
					{
						image_index = 7;
						image_speed = 0;
				
						//Jump
						vSpeed -= jumpHeight;
					}
					
					if (vSpeed > 0)
					{
						image_speed = 1;
						image_index++;
					}
				break;
				
				case 8: //Falling
					
					if (image_speed != 0)
					{
						image_speed = 0;
						image_index = 8;
					}
					
					if (IsOnGround())
					{
						image_speed = 1;
						image_index++;
					}
					
				break;
			}
			
			//Horizontal movement
			if (!IsOnGround()) hSpeed = 1 * (image_xscale * -1);
			else
			{
				hSpeed = 0;
			}
			
		}
		#endregion
			
		#endregion
	break;
	
	case states.dead:
		#region
		if (sprite_index != deadSprite)
		{
			sprite_index = deadSprite;
			image_index = 0;
			image_speed = 1;
		}
		
		//Animation end actions
		#endregion
	break;
	
	case states.still:
		//Do anything
	break;
}

//Purge decimals in vSpeed
#region 
//hSpeedFinal = hSpeed + hSpeedF;
//hSpeedF = hSpeedFinal - floor(abs(hSpeedFinal))*sign(hSpeedFinal);
//hSpeedFinal -= hSpeedF;
hSpeedFinal = hSpeed;

vSpeedFinal = vSpeed + vSpeedF;
vSpeedF = vSpeedFinal - floor(abs(vSpeedFinal))*sign(vSpeedFinal);
vSpeedFinal -= vSpeedF;
#endregion

TileCollisionCheck();

x += hSpeedFinal;
y += vSpeedFinal;