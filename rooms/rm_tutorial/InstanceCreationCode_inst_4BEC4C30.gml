/// @description Insert description here
// You can write your code in this editor

highlight_index = 1;
pos_x = 672;
pos_y = 288;
facing = dir.up;
task_completed = false;
subtitles_triggered = false;

function interact() {
	if(obj_door_lock_visualisation.image_index == 3){
		obj_game.door_keys_required = 3;
		task_completed = true;
		obj_player.can_move = false;
		with(obj_door_lock){
			instance_destroy();
		}
		obj_door.image_speed = 2;	
		alarm[0] = 60 * 2; //player waiting for 2 seconds while animations/sounds complete.
		obj_player.player_interacting = false;
	
		if (obj_game.door_keys_required == 0 and !obj_game.door_unlocked){
			//timer stopped
			obj_user_interface.timer_on = false;		
			task_completed = true; //higlighting no longer enabled
			obj_game.door_unlocked = true;
			obj_player.can_move = false;
			obj_player.player_interacting = false;
		
			//animation of doors opening
			obj_door.image_speed = 2;	
		
			//To do: play celebration audio
		
			//removal of door lock object
			with(obj_door_lock){
				instance_destroy();
			}
			alarm[0] = 60 * 2; //player waiting for 2 seconds while animations/sounds complete.
		}
		else{
			obj_player.player_interacting = false;
		}
	}
	else{
		if (!subtitles_triggered) {
			obj_player.can_move = false;
			with (obj_user_interface) {
				subtitle_index = 0;
				dialog_index = 1;
				text_index = 0;                    
				typing_speed = 40; 
			    dialog = ["To escape the room all lights above the door need to be green.", "If only there was something nearby that could unlock the door..."];
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
}
