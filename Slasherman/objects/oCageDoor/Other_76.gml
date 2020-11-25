/// @desc
var sequenceMessage = event_data[? "message"];
var sequenceElement = event_data[? "element_id"];

if (sequenceMessage == "pauseDoor")
{
	layer_sequence_pause(sequenceElement);
	image_index = 1;
	alarm[0] = room_speed * 30;
}