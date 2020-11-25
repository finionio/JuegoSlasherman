camera = view_camera[0];
cameraWidthHalf = CAMERA_WIDTH / 2;
cameraHeightHalf = CAMERA_HEIGHT / 2;
cameraSpeed = 0.5;

target = oPlayer;
prevTarget = target;

//Screenshake
originalX = 0;
originalY = 0;

enum cameraStates
{
	follow,
	free
}
state = cameraStates.follow;