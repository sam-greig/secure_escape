highlight_index = 14;
pos_x = 561;
pos_y = 416;
task_completed = false;
facing = dir.up;
employee_id_index = 1;
end_obj = obj_cipher_note_small;
collected = false;
subtitles_triggered = false;

function interact(){
	//shows subtitles
	if (!subtitles_triggered) {
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 0;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["You searched the bin and found a crumpled up note!"];
		    show_subtitles = true;
		}
		subtitles_triggered = true;
	}
	if(!collected and !obj_user_interface.show_subtitles){
		collected = true;
		//disable player movement
		with (obj_player){
			player_interacting = false;
		}	
		//hide highlighting
		pos_y = 10000;
		instance_destroy(inst_cipher_note_piece_2_1);
		alarm[3] = 1;
	}
}