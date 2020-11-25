/// @desc

//if (hSpeed == 0) state = states.idle;
//else state = states.walking;

vSpeed += grv;

switch (state)
{
	case states.idle:
		if (sprite_index != sBossIdle)
		{
			sprite_index = sBossIdle;
			image_speed = 1;
			image_index = 0;
		}
		walkSpd = 0;
	break;
	
	case states.walking:
		if (sprite_index != sBossWalking)
		{
			sprite_index = sBossWalking;
			image_speed = 1;
			image_index = 0;
		}
		hSpeed = walkSpd;
	break;
	
	case enemyStates.stepping:
		if (sprite_index != sBossStepping)
		{
			sprite_index = sBossStepping;
			image_speed = 1;
			image_index = 0;
		}
		
		if (image_index == 3) shake = true;
		
		if (shake) ScreenShake(100, 1, 15, 1);
		
	break;
}

//Facing direction
if (hSpeed < 0) image_xscale = -1;
if (hSpeed > 0) image_xscale = 1;

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
