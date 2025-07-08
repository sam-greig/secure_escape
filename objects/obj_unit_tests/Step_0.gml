/// @description Insert description here
// You can write your code in this editor

if(!obj_game.debug) {exit};

var test_case_pass = true;
if(room == rm_escape_room){
	if(obj_user_interface.timer_on == true and !room_loaded) {room_loaded = true};
	if(!room_loaded or waiting or test_cases_finished) {exit};
	switch(test_index){		
		case 0: 
			//Testing timer is turned off when game is paused correctly
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 1");
			show_debug_message("--------------------------------");
			show_debug_message("Testing: Timer should be on, test case result: " +string(obj_user_interface.timer_on == true));
			waiting = true;
			alarm[0] = 60;
			break;
		case 1:
			show_debug_message("Key Pressed: Open/Close Key");
			keyboard_key_press(global.controls[5].value); //escape key is pressed
			keyboard_key_release(global.controls[5].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 2:
			show_debug_message("Testing: Timer should be off, test case result: " +string(obj_user_interface.timer_on == false));
			waiting = true;
			alarm[0] = 60;
			break;
		case 3:
			//Testing game pause variable is updated correctly
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 2");
			show_debug_message("--------------------------------");
			show_debug_message("Testing: Game should be paused: " +string(obj_game.game_paused == true));
			waiting = true;
			alarm[0] = 60;
			break;
		case 4:
			show_debug_message("Key Pressed: Open/Close Key");
			keyboard_key_press(global.controls[5].value); //escape key is pressed
			keyboard_key_release(global.controls[5].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 5:
			show_debug_message("Testing: Game should not be paused: " +string(obj_game.game_paused == false));
			waiting = true;
			alarm[0] = 60;
			break;
		case 6: 
			//Testing player direction should be facing up
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 3");
			show_debug_message("--------------------------------");
			show_debug_message("Key Pressed: Up Key");
			keyboard_key_press(global.controls[0].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 7:
			keyboard_key_release(global.controls[0].value);
			show_debug_message("Testing: Player should be facing up: " +string(obj_player.facing == dir.up));
			waiting = true;
			alarm[0] = 60;
			break;
		case 8:
			//Testing player direction should be facing down
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 4");
			show_debug_message("--------------------------------");
			show_debug_message("Key Pressed: Down Key");
			keyboard_key_press(global.controls[1].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 9:
			keyboard_key_release(global.controls[1].value);
			show_debug_message("Testing: Player should be facing down: " +string(obj_player.facing == dir.down));
			waiting = true;
			alarm[0] = 60;
			break;
		case 10:
			//Testing player direction should be facing left
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 5");
			show_debug_message("--------------------------------");
			show_debug_message("Key Pressed: Left Key");
			keyboard_key_press(global.controls[2].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 11:
			keyboard_key_release(global.controls[2].value);
			show_debug_message("Testing: Player should be facing left: " +string(obj_player.facing == dir.left));
			waiting = true;
			alarm[0] = 60;
			break;
		case 12:
			//Testing player direction should be facing right
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 6");
			show_debug_message("--------------------------------");
			show_debug_message("Key Pressed: Right Key");
			keyboard_key_press(global.controls[3].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 13:
			keyboard_key_release(global.controls[3].value);
			show_debug_message("Testing: Player should be facing right: " +string(obj_player.facing == dir.right));
			waiting = true;
			alarm[0] = 60;
			break;
		case 14:
			//Testing player interaction with tv being off
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 7");
			show_debug_message("--------------------------------");
			obj_player.x = inst_tv_interaction.x+10;
			obj_player.y = inst_tv_interaction.y+10;
			show_debug_message("Key Pressed: Up Key");
			keyboard_key_press(global.controls[0].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 15:
			keyboard_key_release(global.controls[0].value);
			show_debug_message("Key Pressed: Interact Key");
			keyboard_key_press(global.controls[4].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 16:
			keyboard_key_release(global.controls[4].value);
			show_debug_message("Testing: Player should be interacting: " +string(obj_player.player_interacting == true));
			show_debug_message("Testing: Player should not be able to move: " +string(obj_player.can_move == false));
			show_debug_message("Testing: Subtitles should be shown to the player: " +string(obj_user_interface.show_subtitles == true));
			waiting = true;
			alarm[0]= 60;
			show_debug_message("Key Pressed: Interact Key (finishes subtitles being drawn)");
			keyboard_key_press(global.controls[4].value);
			keyboard_key_release(global.controls[4].value);
			show_debug_message("Key Pressed: Interact Key (closes subtitles)");
			keyboard_key_press(global.controls[4].value);
			break;
		case 17:
			keyboard_key_release(global.controls[4].value);
			show_debug_message("Testing: Player should not be interacting: " +string(obj_player.player_interacting == false));
			show_debug_message("Testing: Player should be able to move: " +string(obj_player.can_move == true));
			show_debug_message("Testing: Subtitles should no longer be shown to the player: " +string(obj_user_interface.show_subtitles == false));
			waiting = true;
			alarm[0]= 60;
			break;
		case 18:
			//Testing social media board interactions
			show_debug_message("--------------------------------");
			show_debug_message("Test Case 8");
			show_debug_message("--------------------------------");
			obj_player.x = inst_social_media_board_interaction.x+10;
			obj_player.y = inst_social_media_board_interaction.y+10;
			show_debug_message("Key Pressed: Interact Key");
			keyboard_key_press(global.controls[4].value);
			waiting = true;
			alarm[0] = 60;
			break;
		case 19:
			keyboard_key_release(global.controls[4].value);
			show_debug_message("Testing: Player should be interacting: " +string(obj_player.player_interacting == true));
			show_debug_message("Testing: Player should not be able to move: " +string(obj_player.can_move == false));
			show_debug_message("Testing: Player should be viewing overlay: " +string(obj_user_interface.draw_overlay == true));
			show_debug_message("Testing: Player should be viewing social media board: " +string(obj_user_interface.overlay_target == spr_social_media_board));
			waiting = true;
			alarm[0]= 60;
			show_debug_message("Key Pressed: Interact Key");
			keyboard_key_press(global.controls[4].value);
			break;
		case 20:
			keyboard_key_release(global.controls[4].value);
			show_debug_message("Testing: Player should be viewing overlay: " +string(obj_user_interface.draw_overlay == true));
			show_debug_message("Testing: Player should be viewing social media post: " +string(obj_user_interface.overlay_target == spr_social_media_posts));
			waiting = true;
			alarm[0]= 60;
			keyboard_key_press(global.controls[5].value);
			show_debug_message("Key Pressed: Open/Close Key");
			keyboard_key_release(global.controls[5].value);
			break;
		case 21:
			keyboard_key_press(global.controls[5].value);
			show_debug_message("Key Pressed: Open/Close Key");
			keyboard_key_release(global.controls[5].value);
			waiting = true;
			alarm[0]= 60;
			break;
		case 22:
			show_debug_message("Testing: Player should not be interacting: " +string(obj_player.player_interacting == false));
			show_debug_message("Testing: Player should be able to move: " +string(obj_player.can_move == true));
			show_debug_message("Testing: Overlay should no longer be shown to the player: " +string(obj_user_interface.draw_overlay == false));
			waiting = true;
			break;
	}
}






