highlight_index = 15;
pos_x = 672;
pos_y = 144;
task_completed = false;
facing = dir.left;
selected_index = 0;

function interact(){
	with (obj_player){
		can_move = false;
		player_interacting = true;
	}
	//display laptop emails
	with (obj_user_interface){
		draw_overlay = true;
		overlay_target = spr_social_engineering_notes;
		overlay_sub_img = other.selected_index;
		overlay_scale_x = 2;
		overlay_scale_y = 2;
		offset_width = 1;
		offset_height = 1;
	}
	
	//player clicks left
	if(keyboard_check_pressed(global.controls[2].value)){
		if(selected_index > 0){
			selected_index -= 1;
		}
	}
	
	//player clicks right
	if(keyboard_check_pressed(global.controls[3].value)){
		if(selected_index < 2){
			selected_index += 1;
		}
	}
	
	if(keyboard_check_pressed(global.controls[5].value)){ //checks if player exits
		obj_player.can_move = true
		obj_player.player_interacting = false;
		obj_user_interface.draw_overlay = false;
		selected_index = 0;
	}	
}