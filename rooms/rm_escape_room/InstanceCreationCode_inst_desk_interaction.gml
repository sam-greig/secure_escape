highlight_index = 8;
pos_x = 688;
pos_y = 264;
facing = dir.up;
task_completed = false;
selected_index = 0;
viewing = false;
desk_item_index = 0;


//password variables.
password_input = "";
max_length = 16;
correct_password = "MomoandTiger1!";
keyboard_string_reset = false;
password_correctly_entered = false;

note_taken = false;
subtitles_triggered = false;



function interact(){
	if(obj_user_interface.show_subtitles){
		exit;
	}
	
	
	if(!obj_game.out_of_time){//checks that the player has not ran out of time
		if(!viewing){
			//update player object variables
			with (obj_player){
				can_move = false;
				player_interacting = true;
			}
	
			//player presses up
			if(keyboard_check_pressed(global.controls[0].value)){ //checks if player exits
				selected_index = 2;
			}
			//player presses down
			if(keyboard_check_pressed(global.controls[1].value)){ //checks if player exits
				if(selected_index != 1){
					selected_index = 0;
				}
			}
			//player presses left
			if(keyboard_check_pressed(global.controls[2].value)){ //checks if player exits
				selected_index = 0;
			}
			//player presses right
			if(keyboard_check_pressed(global.controls[3].value)){ //checks if player exits
				if(!password_correctly_entered){
					selected_index = 1;
				}
			}	
	
			//change highlighting variables
			switch(selected_index){
				case 0:
					highlight_index = 9;
					pos_x = 658;
					pos_y = 254;
					break;
				case 1:
					highlight_index = 10;
					pos_x = 704;
					pos_y = 240;
					break;
				case 2:
					highlight_index = 11;
					pos_x = 672;
					pos_y = 220;
					break;
			}
	
			//player interacts
			if(keyboard_check_pressed(global.controls[4].value)){
				viewing = true;
			}
	
			if(keyboard_check_pressed(global.controls[5].value)){ //checks if player exits
				obj_player.can_move = true
				obj_player.player_interacting = false;		
				//reset variables
				selected_index = 0;
				highlight_index = 8;
				pos_x = 688;
				pos_y = 264;
			}
		}
		else{ //player viewing desk item
			with (obj_user_interface){
				draw_overlay = true;
				offset_height = 1;
				switch(other.selected_index){
					case 0: overlay_target = spr_employee_handbook; offset_height = 1.1; break;				
					case 1: overlay_target = spr_locked_laptop; break;
					case 2: overlay_target = spr_sticky_note; break;
				}
				overlay_sub_img = other.desk_item_index;
				overlay_scale_x = 2;
				overlay_scale_y = 2;
				offset_width = 1;
			}
		
			if(selected_index == 0){
				//player clicks left
				if(keyboard_check_pressed(global.controls[2].value)){
					if(desk_item_index > 0){
						desk_item_index -= 1;
					}
				}
				//player clicks right
				if(keyboard_check_pressed(global.controls[3].value)){
					if(desk_item_index < 2){
						desk_item_index += 1;
					}
				}
			
				if(desk_item_index == 2){
					//draws a cipher note piece
					if(!note_taken){//while not collected
						var inst_note_piece = instance_create_depth(x, y, 0, obj_draw_sprite);
						with(inst_note_piece){
							drawing = true;
							sprite_name = spr_cipher_note_piece_1;
							sprite_sub_image = 0;
							pos_x = display_get_gui_width()/2;
							pos_y = display_get_gui_height()/2;
							pos_x = display_get_gui_width() / 2 - sprite_get_width(sprite_name);
							pos_y = display_get_gui_height() / 2 - sprite_get_height(sprite_name);
							xscale = 2;
							yscale = 2;
						}
						inst_note_piece.alarm[0] = 2;
						//player collects note
						if(keyboard_check_pressed(global.controls[4].value)){
							if(instance_exists(inst_note_piece)){
								instance_destroy(inst_note_piece);
								note_taken = true;
								obj_cipher_note_small.image_index += 1;
							}
						}
					}
				}
			
			}
			else if (selected_index == 1){
				//user enters password correctly
				if(password_correctly_entered){
					obj_user_interface.draw_overlay = false;
					viewing = false;
					return;
				}
				else{			
					var incorrect_password = instance_create_depth(x, y, 0, obj_draw_text);
					//resets global keyboard_string
					if(!keyboard_string_reset){
						keyboard_string = "";
						keyboard_string_reset = true;
					}

					//user presses the back button to remove a character
					if (keyboard_check_pressed(vk_backspace) and string_length(password_input) > 0) {
					    password_input = string_copy(password_input, 1, string_length(password_input) - 1);
					}

					if (keyboard_check_pressed(vk_enter)) {
					    if (password_input == correct_password) {
							//turns TV obj on
							with (obj_interaction) {
							    if (variable_instance_exists(id, "tv_on")) {
							        tv_on = true;
							    }
							}
							obj_memorise_game.image_index += 1;
							password_correctly_entered = true;
							obj_user_interface.draw_overlay = false;
							viewing = false;
							selected_index = 0;
							//shows subtitles
							if (!subtitles_triggered) {
								obj_player.can_move = false;
								with (obj_user_interface) {
									subtitle_index = 0;
									dialog_index = 0;
									text_index = 0;                    
									typing_speed = 40; 
								    dialog = ["Looks like the TV has turned on."];
								    show_subtitles = true;
								}
								subtitles_triggered = true;
							}
							return;
					    } else {
					        //entered password is incorrect - display to player
							with(incorrect_password){
								drawing = true;
								input_text = ["Password Incorrect"];
								text_colour = c_red;
								text_font = fnt_rockwell_32px;
								pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings)-200;
								pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)+20;
								calculate_string_width = false;
								offset_x = 0;
								offset_y = 0;
							}
							//keyboard and input reset
							keyboard_string_reset = false;
					        password_input = "";
					    }
					}
				
					if(subtitles_triggered and !obj_user_interface.show_subtitles){
					
					}

					//captures player text input
					if (string_length(password_input) < max_length) {
						if(string_length(keyboard_string) < max_length){
							password_input = keyboard_string;
						}
						else{
							password_input = string_copy(keyboard_string, 1, max_length);
						}
					}			
					//displays length of input password in *'s
					var displayed_password = instance_create_depth(x, y, 0, obj_draw_text);
					with(displayed_password){
						drawing = true;
						input_text = [string_repeat("*", string_length(other.password_input))];
						text_colour = c_black;
						text_font = fnt_rockwell_32px;
						pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings)-200;
						pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)-35;
						calculate_string_width = false;
						offset_x = 0;
						offset_y = 0;
					}
				
					displayed_password.alarm[0] = 2;
					incorrect_password.alarm[0] = 60;
					keyboard_string = password_input;
				}
			}
		
		
			if(keyboard_check_pressed(global.controls[5].value) and !obj_user_interface.show_subtitles){ //checks if player exits
				obj_user_interface.draw_overlay = false;		
				//reset variables
				viewing = false;
				desk_item_index = 0;
				keyboard_string_reset = false;
				password_input = "";
			}
		}
	}
	else{
		obj_player.can_move = true
		obj_player.player_interacting = false;
		
	}
}