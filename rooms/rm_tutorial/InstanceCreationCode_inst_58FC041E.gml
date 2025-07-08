highlight_index = 9;
pos_x = 754;
pos_y = 446;
task_completed = false;
facing = dir.right;
employee_id_index = 1;
disable_interact_button = true;
subtitles_triggered = false;

function interact(){
	disable_interact_button = false;
	inst_6BE179A1.disable_interact_button = false;
	inst_3A6A52EA.disable_interact_button = false;
	//shows subtitles
	if (!subtitles_triggered) {
		obj_player.can_move = false;
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 1;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["Interactable objects are highlighted in yellow when facing them.", "To interact with an object you must be facing it and clicking the interact button (Default: Enter)."];
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