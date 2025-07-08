highlight_index = 16;
pos_x = 593;
pos_y = 411;
task_completed = false;
facing = dir.up;
employee_id_index = 1;
disable_interact_button = true;
subtitles_triggered = false;

function interact(){
	disable_interact_button = false;
	inst_3991FAF3.disable_interact_button = false;
	inst_3E76FE74.disable_interact_button = false;
	inst_D665AC5.disable_interact_button = false;
	//shows subtitles
	if (!subtitles_triggered) {
		obj_player.can_move = false;
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 1;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["Notes are found near puzzles. If you are stuck solving a puzzle make sure to view these!", 
			"Notes contain some information that may help you in solving the current puzzle and also provide information about the cybersecurity topic."];
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