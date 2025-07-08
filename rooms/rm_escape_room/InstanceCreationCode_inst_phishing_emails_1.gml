highlight_index = 2;
pos_x = 848;
pos_y = 85;
task_completed = false;
facing = dir.right;
selected_email_index = 0;

function interact(){
	with (obj_player){
		can_move = false;
		player_interacting = true;
	}
	//display laptop emails
	with (obj_user_interface){
		draw_overlay = true;
		overlay_target = spr_emails;
		overlay_sub_img = other.selected_email_index;
		overlay_scale_x = 2;
		overlay_scale_y = 2;
		offset_width = 1;
		offset_height = 1;
	}
	
	if(keyboard_check_pressed(global.controls[5].value)){ //checks if player exits
		obj_player.can_move = true
		obj_player.player_interacting = false;
		obj_user_interface.draw_overlay = false;
		selected_email_index = 0;
	}
	
	if (keyboard_check_pressed(global.controls[0].value)){
		if (selected_email_index > 0){
			selected_email_index -= 1;
		}
	}
	
	if (keyboard_check_pressed(global.controls[1].value)){
		if (selected_email_index < 4){
			selected_email_index += 1;
		}
	}
	
}