/// @description Insert description here
// You can write your code in this editor

//set obj create variables
highlight_index = 3;
pos_x = 720;
pos_y = 63;
facing = dir.up;
task_completed = false;
end_obj = obj_door;

//selection variables
selected_index = 0;
selected_column = 0;
selected_row = 0;

//input code variables
current_keypad_index = 0;
keypad_values = [7,8,9,4,5,6,1,2,3,"x",0,"tick"];
correct_code = [1,8,1,1];
player_input_code = array_create(4, -1);
keyboard_reset = false;

//guessing boolean flags
wrong_guess = false;
disable_input = false;

function reset_variables(){
	player_input_code = array_create(4, -1);
	current_keypad_index = 0;
	selected_index = 0;
	selected_column = 0;
	selected_row = 0;
}

function interact() {
	//player makes a wrong guess
	if(wrong_guess){
		//image index reset
		obj_user_interface.overlay_sub_img = 0;
		//variables reset
		reset_variables();
		//flags reset
		wrong_guess = false;
		disable_input = false;
	}
	else{
		if (!disable_input){
			if(keyboard_check_pressed(global.controls[5].value) and !task_completed){//reset key)){ //checks if player exits and reset flags
					obj_player.can_move = true
					obj_player.player_interacting = false;
					obj_user_interface.draw_overlay = false;
					obj_draw_text.drawing = false;
					keyboard_reset = false;		
					//reset previous data
					reset_variables();			
					return; //avoid running code after this line
			}
				var input_value = -1;
				if(!keyboard_reset){ //avoids double enter input and resets the key
						keyboard_clear(global.controls[4].value);
						keyboard_reset = true;
				}
				with(obj_user_interface){
					overlay_target = spr_keypad;
					overlay_sub_img = 0;
					overlay_scale_x = 2;
					overlay_scale_y = 2;
					offset_width = 1;
					offset_height = 1;
					draw_overlay = true;
				}
			if (!task_completed){
				obj_player.can_move = false; //disables player movement
				obj_player.player_interacting = true; //player is currently interacting	
				//choose selected media post
				if(keyboard_check_pressed(global.controls[2].value)){		
						if (selected_column-1 >= 0){
							selected_column -= 1;
							selected_index -= 1;
						}
				}
				if(keyboard_check_pressed(global.controls[3].value)){
						if (selected_column+1 <= 2){
							selected_column += 1;
							selected_index += 1;
						}
				}
				if(keyboard_check_pressed(global.controls[0].value)){
						if (selected_row-1 >= 0){
							selected_row -= 1;
							selected_index -= 3;
						}
				}
				if(keyboard_check_pressed(global.controls[1].value)){
						if (selected_row+1 <= 3){
							selected_row += 1;
							selected_index += 3;
						}
				}
				//user has selected a key on the keypad
				if(keyboard_check_pressed(global.controls[4].value)){
					keyboard_clear(global.controls[4].value); //resets key
					if (keypad_values[selected_index] == "x"){			
						if (current_keypad_index > 0){
							player_input_code[current_keypad_index-1] = -1;
							current_keypad_index -= 1;
						}
						else{ //must be index 0
							player_input_code[current_keypad_index] = -1;
						}
			
					}
					else if (keypad_values[selected_index] == "tick"){
						selected_index = 12; //light turns off while the players code is analysed
						disable_input = true; //disable player being able to move their selection while guessing
						if(current_keypad_index == 4){
							//show_debug_message(correct_code);
							if (array_equals(player_input_code, correct_code)){ //player has entered the correct passcode
								alarm[2] = 30; //0.5 second
							}
							else{ //provide instant feedback that the player has got it wrong
								alarm[1] = 30; // 0.5 second
							}
						}
						else{ //provide instant feedback that the player has got it wrong
								alarm[1] = 30; // 0.5 second
						}
					}
					else{
						if (current_keypad_index < 4){
							player_input_code[current_keypad_index] = keypad_values[selected_index];
							current_keypad_index += 1;
						}
					}	
				}
				var drawn_code = [];
				//loops through player_input_code and adds valid numbers to draw
				for (var i = 0; i < array_length(player_input_code); i++) {
				    if (player_input_code[i] != -1) {
				        array_push(drawn_code, player_input_code[i]); // Add valid number to the array
				    }
				}				
				//show_debug_message(string(drawn_code));
				//draw input code
				with(obj_draw_text){
					input_text = drawn_code;
					pos_x = display_get_gui_width()/2 - sprite_get_height(spr_keypad)/3+10;
					pos_y = display_get_gui_height() - sprite_get_height(spr_keypad) - 14;
					offset_x = 64;
					drawing = true;
				}	
	
				obj_user_interface.overlay_sub_img = selected_index;
			}
			else{ //user made correct guess. Display green light.
				obj_user_interface.overlay_sub_img = 13;
				with (obj_keypad) { //update outside object visual
				    if (keypad_id == "0") { 
				        image_index = 1;
				    }
				}
			}
		}
	}
}
