
function TileCollisionCheck(){
	var bbox_side;
	
	//HORIZONTAL
	if (hSpeed > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
	if (tilemap_get_at_pixel(global.collisionMap, bbox_side + hSpeedFinal, bbox_top) != 0
	|| tilemap_get_at_pixel(global.collisionMap, bbox_side + hSpeedFinal, bbox_bottom) != 0)
	{
		if (hSpeed > 0) x = x - (x mod TILE_SIZE) + 15 - (bbox_right - x);
		else x = x - (x mod TILE_SIZE) - (bbox_left - x);
	
		hSpeed = 0;
		//hSpeedF = 0;
		hSpeedFinal = 0;
	} 

	//VERTICAL
	if (vSpeed > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
	if (tilemap_get_at_pixel(global.collisionMap, bbox_right, bbox_side + vSpeedFinal) != 0
	|| tilemap_get_at_pixel(global.collisionMap, bbox_left, bbox_side + vSpeedFinal) != 0)
	{
		if (vSpeed > 0) y = y - (y mod TILE_SIZE) + 15 - (bbox_bottom - y);
		else y = y - (y mod TILE_SIZE) - (bbox_top - y);
	
		vSpeed = 0;
		vSpeedF = 0;
		vSpeedFinal = 0;
	}
	//OneWayPlatform
	if (vSpeed > 0)
	{
		if (tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + vSpeedFinal) != 0
		|| tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + vSpeedFinal) != 0) &&
		/*(tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom - 1) == 0
		|| tilemap_get_at_pixel(global.OneWayPlatformMap,bbox_right, bbox_bottom - 1) == 0 ) &&*/
		( tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_left - 1,bbox_bottom) == 0 
		&& tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_right + 1, bbox_bottom) == 0 )
		{
			y = y - (y mod TILE_SIZE) + 15 - (bbox_bottom - y);
			vSpeed = 0;
			vSpeedF = 0;
			vSpeedFinal = 0;
		}
	}
}

function IsOnGround(){
	if (tilemap_get_at_pixel(global.collisionMap,bbox_left, bbox_bottom + 1) != 0
	|| tilemap_get_at_pixel(global.collisionMap, bbox_right, bbox_bottom + 1) != 0
	|| tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_right, bbox_bottom + 1) != 0
	|| tilemap_get_at_pixel(global.OneWayPlatformMap, bbox_left, bbox_bottom + 1) != 0)
	{ return true;}
	else return false;
}

function ScreenShake(_number, _intensity, _wait, _duration){
	/// @desc				This function is used to make the camera shake
	/// @arg	number		The number of screenshakes to do
	/// @arg	intensity	The intensity of the shakes (1=normal 2 = hard)
	/// @arg	wait		The duration in frames to wait between shakes
	/// @arg	duration	The duration in seconds of the shake
	
	static _currentNumber = 0;
	static _frames = 0;
	static _magnitude = 0;
	static _decreaseAmount = _intensity / (_duration * room_speed);
	
	with (oCamera)
	{
		if (_currentNumber == _number)	
		{
			x = originalX;
			y = originalY;
			originalX = 0;
			originalY = 0;
			_currentNumber = 0;
			_frames = 0;
			_magnitude = 0;
			
			return true;
		}
		else
		{
			//Setting the origin to return at the end
			if (originalX == 0 && originalY = 0)
			{
				originalX = x;
				originalY = y;
				_magnitude = _intensity;
				_decreaseAmount = _intensity / (_duration * room_speed);
			}
		
			x = random_range(originalX - _magnitude, originalX + _magnitude);
			y = random_range(originalY - _magnitude, originalY + _magnitude);
		
			//Decreasing magnitude
			_magnitude = max(0, _magnitude - _decreaseAmount);
		
			// If a screenshake ends
			if (_magnitude == 0)
			{
				_frames = min(_frames + 1, _wait);
			
				// If wait frames already passed
				if (_frames == _wait)
				{
					_magnitude = _intensity;
					_frames = 0;
					_currentNumber++;
				}
			}
			return false;
		}
	}
}