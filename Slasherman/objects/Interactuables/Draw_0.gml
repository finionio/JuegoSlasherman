/// @desc
draw_self();

if (global.debug)
{
	draw_circle(x,y,1, 0);
	draw_rectangle(x + (-1*range), bbox_top, x + range, bbox_bottom, true);
}