/// @desc

// Inherit the parent event
if (!dead) event_inherited();

if (instance_exists(oTextbox) && textbox.page == 2 && !dead)
{
	sprite_index = sAdventurerDeath;
	dead = true;
}

if (dead && !instance_exists(textbox))
{
	oPlayer.swordless = 0;
	oLevelAssistant.tutorial = true;
}