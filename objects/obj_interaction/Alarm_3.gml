/// @description Insert description here
// You can write your code in this editor
obj_player.player_interacting = false;
obj_user_interface.draw_overlay = false;
obj_draw_text.drawing = false;
camera_set_view_target(view_camera[0], obj_camera);
with(obj_camera){
	enabled = true;
	starting_pos_x = obj_player.x;
	starting_pos_y = obj_player.y;
	end_pos_x = other.end_obj.x;
	end_pos_y = other.end_obj.y;
}
if(end_obj == obj_cipher_note_small){
	obj_cipher_note_small.image_index += 1;
	alarm[4] = 60 * 5.1;
}
else{
	obj_camera.puzzle_completed = true;
}
alarm[0] = 60*5;





