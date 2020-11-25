/// @desc
// % slow text (textSpeed = 0.2)
// # pause text 50 frames
// $ wait 3 seconds after current page

var next = keyboard_check_pressed(ord("C"));

switch (state)
{
	case textboxStates.printing:
	#region
	
	draw_sprite(sTextbox,0, xTextbox, yTextbox);

	str = string_copy(text[page], 0, l);
	
	//Check for special chars
	for (var i = 0; i < array_length(specialChars); i++)
	{
		if (string_char_at(str, l) == specialChars[i])
		{
			switch(specialChars[i])
			{
				case "%": textSpeed = 0.2;
				break;
				
				case "#": pause = 50;
				break;
				
				case "$": wait = true;
				break;
			}
			
			str = string_delete(str, l, 1);
			text[page] = string_delete(text[page], l, 1);
		}
	}

	draw_text_ext(xText, yText, str, sep, widthText);

	if (pause == 0)
	{
		//Text progression
		if (str == text[page])
		{
			if (next)
			{
				if (wait) state = textboxStates.waiting;
				else
				{
					if (page < array_length(text) - 1)
					{
						page++; 
						l = 0;
						textSpeed = 0.5;
					}
					else instance_destroy();
				}
			}
		}
		else
		{
			l += textSpeed;
		}
	}
	else pause --;
	
	#endregion
	break;
	
	case textboxStates.waiting:
		if (alarm[0] == -1)
		{
			alarm[0] = room_speed * 3;
		}
	break;
}