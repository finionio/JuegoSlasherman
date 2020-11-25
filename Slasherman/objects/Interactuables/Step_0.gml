if (collision_rectangle(x + (-1*range), bbox_top, x + range, bbox_bottom, oPlayer, 0,0 ))
{
	image_index = 1;
	
	if (keyboard_check_pressed(ord("C")) && !instance_exists(oTextbox))
	{
		io_clear();
		
		textbox = instance_create_layer(x,y, "Instances", oTextbox);
		with (textbox)
		{
			for (var i = 0; i < array_length(other.text); i++)
			{
				text[i] = other.text[i];
			}
			creator = other.id;
		}
	}
}
else image_index = 0;