/// @desc

if (collision_rectangle(x - cameraWidthHalf, y - cameraHeightHalf, x + cameraWidthHalf, y + cameraHeightHalf, oPlayer, 0, 0))
{
	oCamera.target = self;
}
else oCamera.target = oPlayer;

if (global.debug) visible = true;
else visible = false;