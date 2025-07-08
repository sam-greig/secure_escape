/// @description Debug view

if(!debug){exit;}

//collision objects
with(obj_collision){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
	draw_set_alpha(1);
}

with(obj_collision_circle){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
	draw_set_alpha(1);
}
with(obj_door_lock){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
	draw_set_alpha(1);
}

//room depth objects
with(obj_room_depth){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_purple, c_purple, c_purple, c_purple, false);
	draw_set_alpha(1);
}

//transition objects
with(obj_transition){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_green, c_green, c_green, c_green, false);
	draw_set_alpha(1);
}

//interaction objects
with(obj_interaction){
	draw_set_alpha(0.3);
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_yellow, c_yellow, c_yellow, c_yellow, false);
	draw_set_alpha(1);
}

//draws player collision mask
with(obj_player){
	draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_yellow, c_yellow, c_yellow, c_yellow, true);
	draw_set_alpha(1);
}
