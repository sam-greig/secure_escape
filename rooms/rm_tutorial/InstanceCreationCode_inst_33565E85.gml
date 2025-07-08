highlight_index = 0;
pos_x = 1754;
pos_y = 1446;
task_completed = false;
facing = dir.up;
employee_id_index = 1;
disable_interact_button = true;
subtitles_triggered = false;

function interact(){
	//clears obj_game room start key press
	keyboard_clear(global.controls[0].value);
	disable_interact_button = false;
	//shows subtitles
	if (!subtitles_triggered) {
		obj_player.can_move = false;
		with (obj_user_interface) {
			subtitle_index = 0;
			dialog_index = 4;
			text_index = 0;                    
			typing_speed = 40; 
		    dialog = ["Welcome to the Secure Escape tutorial! The goal of this game is to escape the room as quickly as possible.", 
			"To move your character you can press your movement keys (Default: Arrow Keys).",
			"To pause the game at any given time you can press the exit button (Default: Esc Key). In the pause menu you can change the controls.", 
			"If you are already interacting with something in the room you must exit out of the item or finish reading text prompts to be able to pause the game.",
			"Feel free to explore around the tutorial room and head towards the door when you're ready to start the escape room."];
		    show_subtitles = true;
		}
		subtitles_triggered = true;
	}
	if(!obj_user_interface.show_subtitles){
		keyboard_clear(global.controls[4].value);
		obj_player.can_move = true;
		obj_player.player_interacting = false;
		instance_destroy();
	}
}