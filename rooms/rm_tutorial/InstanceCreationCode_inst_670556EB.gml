highlight_index = 10;
pos_x = 768;
pos_y = 304;
task_completed = false;
facing = dir.right;
employee_id_index = 1;
disable_interact_button = true;
subtitles_triggered = false;

function interact(){
	disable_interact_button = false;
	inst_3512F21B.disable_interact_button = false;
	//shows subtitles
	if (!subtitles_triggered) {
		obj_player.can_move = false;
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 0;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["Some puzzles may require text input."]
		    show_subtitles = true;
		}
		subtitles_triggered = true;
	}
	if(!obj_user_interface.show_subtitles){
		keyboard_clear(global.controls[4].value);
		obj_player.can_move = true;
		obj_player.player_interacting = false;
		subtitles_triggered = false;
	}
}