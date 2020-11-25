
x = mouse_x;
y = mouse_y;

if (collision_rectangle(oTest.bbox_left, oTest.bbox_top, oTest.bbox_right,
	oTest.bbox_bottom, self, 0,0))
	{
		test = true;
	}
else test = false;