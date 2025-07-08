/// @description Insert description here
// You can write your code in this editor

highlight_index = 12;
pos_x = 399;
pos_y = 312;
task_completed = false;
facing = dir.up;

function interact(){
	with (obj_player){
		can_move = false;
		player_interacting = true;
	}
	//display cipher note
	with (obj_user_interface){
		draw_overlay = true;
		overlay_target = spr_cipher_note;
		overlay_sub_img = obj_cipher_note_small.image_index;
		overlay_scale_x = 2;
		overlay_scale_y = 2;
		offset_width = 1;
		offset_height = 1;
	}
	
	if(keyboard_check_pressed(global.controls[5].value)){ //checks if player exits
		obj_player.can_move = true
		obj_player.player_interacting = false;
		obj_user_interface.draw_overlay = false;
	}	
}
