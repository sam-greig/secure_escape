/// @description Insert description here
// You can write your code in this editor

highlight_index = 1;
pos_x = 608;
pos_y = 96;
facing = dir.up;
task_completed = false;

function interact() {
	show_debug_message(obj_game.door_keys_required);
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
