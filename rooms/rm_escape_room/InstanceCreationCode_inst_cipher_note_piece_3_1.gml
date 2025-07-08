highlight_index = 13;
pos_x = 464;
pos_y = 183;
task_completed = false;
facing = dir.up;
employee_id_index = 1;
end_obj = obj_cipher_note_small;
collected = false;
subtitles_triggered = false;

function interact(){
	//shows subtitles
	if (!subtitles_triggered) {
		obj_player.can_move = false;
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 0;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["You found part of a note!"];
		    show_subtitles = true;
		}
		subtitles_triggered = true;
	}
	if(!collected and !obj_user_interface.show_subtitles){
		collected = true;
		//disable player movement
		with (obj_player){
			can_move = false;
			player_interacting = false;
		}	
		//hide item
		pos_y = 10000;
		with(obj_cipher_note_piece){
			if(item_id == "1"){
				visible = false;
			}
		}
		instance_destroy(inst_cipher_note_piece_3_2);
		alarm[3] = 1;
	}
}