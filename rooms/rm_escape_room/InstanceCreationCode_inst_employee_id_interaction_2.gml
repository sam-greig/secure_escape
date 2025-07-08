highlight_index = 6;
pos_x = 896;
pos_y = 80;
task_completed = false;
facing = dir.up;
employee_id_index = 3;

function interact(){
	with (obj_player){
		can_move = false;
		player_interacting = true;
	}
	//display laptop emails
	with (obj_user_interface){
		draw_overlay = true;
		overlay_target = spr_employee_ids;
		overlay_sub_img = other.employee_id_index;
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