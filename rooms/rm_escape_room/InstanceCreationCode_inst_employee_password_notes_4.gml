highlight_index = 17;
pos_x = 625;
pos_y = 305;
task_completed = false;
facing = dir.down;
selected_index = 0;

function interact(){
	with (obj_player){
		can_move = false;
		player_interacting = true;
	}
	
	//display password notes
	with (obj_user_interface){
		draw_overlay = true;
		overlay_target = spr_password_notes;
		overlay_sub_img = 0;
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