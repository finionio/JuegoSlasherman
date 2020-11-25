//DEBUG
if (global.debug) visible = true;

//Slime hitbox follows
if (creator.object_index == oSlime)
{
	image_index = creator.image_index;
	
	x = creator.x;
	y = creator.y;
}

//PARRY
if (place_meeting(x,y, oHitbox) && creator.parry == true)
{
	if (creator.object_index == oPlayer)
	{
		var _hitboxes = ds_list_create();
		instance_place_list(x,y,oHitbox, _hitboxes,false);
		for (var i = 0; i < ds_list_size(_hitboxes); i++)
		{
			var _inst = ds_list_find_value(_hitboxes,i);
			if (_inst.creator.parry == true)
			{
				//PARRY for PLAYER
				show_debug_message(string(creator) + " Parry");
				//creator state Parry ???
			}
		}
		ds_list_destroy(_hitboxes);
	}
	else //Enemy
	{
		var _hitboxes = ds_list_create();
		instance_place_list(x,y,oHitbox, _hitboxes, false);
		for (var i = 0; i < ds_list_size(_hitboxes); i++)
		{
			var _inst = ds_list_find_value(_hitboxes, i);
			if (_inst.creator.object_index == oPlayer)
			{
				//PARRY for ENEMY
				show_debug_message(string(creator) + " Parry");
				// creator state Parry ???
			}
		}
		
		ds_list_destroy(_hitboxes);
	}	
}

//DAMAGE
if (place_meeting(x,y,Entities))
{
	var _list = ds_list_create();
	instance_place_list(x,y,Entities, _list, false);
	
	for (var i = 0; i < ds_list_size(_list); i++)
	{
		var _inst = ds_list_find_value(_list,i);
		
		if (_inst != creator)
		{
			//From Enemy to Player
			if (object_get_parent( creator.object_index) == oEnemy)
			{
				if (object_get_parent(_inst.object_index) != oEnemy)
				{
					if (_inst.state != states.dead)	
					{
						_inst.state = states.damaged;
						_inst.damageRecieved = creator.damage;
					}
				}
			}
			else //From player to enemy
			{
				if (_inst.state != states.dead)
				{
					_inst.state = states.damaged;
					_inst.damageRecieved = creator.damage;
				}
			}
		}
	}
	
	ds_list_destroy(_list);
}

if (creator.state != states.attacking) instance_destroy();