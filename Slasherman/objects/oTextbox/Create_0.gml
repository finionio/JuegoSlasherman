/// @desc
draw_set_font(fText);
oPlayer.state = states.still;
instance_deactivate_object(oEnemy);
creator = noone;

text = [];
page = 0;
l = 0;
textSpeed = 0.5; 
str = "";
pause = 0;
wait = false;

xTextbox = (GUI_WIDTH/2) - (sprite_get_width(sTextbox)/2);
yTextbox = 10;
xText = xTextbox + 16;
yText = yTextbox + 16;

widthText = sprite_get_width(sTextbox) - 32;
sep = 25;

specialChars = ["%", "#", "$"];

//States
enum textboxStates
{
	printing,
	waiting
}
state = textboxStates.printing;