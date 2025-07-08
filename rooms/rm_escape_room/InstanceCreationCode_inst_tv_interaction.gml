highlight_index = 7;
pos_x = 785;
pos_y = 272;
task_completed = false;
facing = dir.up;
memory_game_index = 0;
game_started = false;
minigame_timer_on = false;
minigame_seconds = 60 * 60;
passwords_generated = false;
incorrect_game_passwords = array_create(20, "");
correct_game_passwords = array_create(10, "");
passwords_populated = false; //remove?
memory_question = false;
chosen_question_index = 0;
tv_on = false;
subtitles_triggered = false;
subtitles_recently_closed = false;
end_obj = obj_door;
timed_out = false;
out_of_time = false;

function generate_passwords(){
	for (var i = 0; i < 10; i++){
		if (i < 4){
			if (i < 2){
				global.dictionary = new PickWordDictionary([
			    working_directory + "dictionaries/dog_names/dog_names.txt",
				]);
				var words = global.dictionary.pickN(3);
				correct_game_passwords[i] = words[0]+"dog1!";
				incorrect_game_passwords[i*2] = words[1]+"dog1!";
				incorrect_game_passwords[i*2+1] = words[2]+"dog1!";
			}
			else{
				global.dictionary = new PickWordDictionary([
			    working_directory + "dictionaries/weak_passwords/weak_passwords.txt",
				]);
				var words = global.dictionary.pickN(3);
				correct_game_passwords[i] = words[0];
				incorrect_game_passwords[i*2] = words[1];
				incorrect_game_passwords[i*2+1] = words[2];
			}
		}
		else if (i < 7){
			var special_chars = "!@#$%^&*()_-+=[]{},.<>?/|~";
			var randIndex = irandom(string_length(special_chars) - 1);
			global.dictionary = new PickWordDictionary([
			working_directory + "dictionaries/simple_by_length/3.txt",
			working_directory + "dictionaries/simple_by_length/4.txt",
			working_directory + "dictionaries/simple_by_length/5.txt",
			]);
			var words = global.dictionary.pickN(9);
			
			correct_game_passwords[i] = words[0] + string_char_at(special_chars, randIndex + 1) + words[1] + words[2];
			incorrect_game_passwords[i*2] = words[3] + string_char_at(special_chars, randIndex + 1) + words[4] + words[5];
			incorrect_game_passwords[i*2+1] = words[6] + string_char_at(special_chars, randIndex + 1) + words[7] + words[8];
		}
		else if (i < 10){
			function complicated_password(){
				var overcomplicated_password = "";
				var random_number = irandom_range(0, 11);
				var characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
				var special_characters = "!@#$%^&*()_-+=[]{},.<>?/|~";
				for (var j = 0; j < 12; j++){
					var rand_index = irandom(string_length(characters) - 1);
					if (j == random_number){
						rand_index = irandom(string_length(special_characters) - 1);
						overcomplicated_password = overcomplicated_password +  string_char_at(special_characters, rand_index + 1);
					}
					else{
						overcomplicated_password = overcomplicated_password +  string_char_at(characters, rand_index + 1);
					}
				}
				return overcomplicated_password;
			}
			correct_game_passwords[i] = complicated_password();
			incorrect_game_passwords[i*2] = complicated_password();
			incorrect_game_passwords[i*2+1] = complicated_password();
		}
	}
	passwords_populated = true;
}

function interact(){
	if(tv_on and !task_completed){
		//obj_memorise_game.image_index = 1;
		var timer_txt_instance = pointer_null;
		var password1_txt_instance = pointer_null;
		var password2_txt_instance = pointer_null;
		var npc_name_txt_instance = pointer_null;
		var npc_profile_spr_instance = pointer_null;
		var npc_profile_spr_instance = pointer_null;
		if(!passwords_generated){
			passwords_generated = true;
			generate_passwords();
		}
	
		if(memory_game_index >= 1 and !game_started){
			game_started = true;
			chosen_question_index = irandom_range(0, 9);
		}
	
		if(game_started and passwords_populated){
			var password1_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
			var password2_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
			var npc_name_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
			var npc_profile_spr_instance = instance_create_depth(x, y, 0, obj_draw_sprite);
		
			if(!memory_question){	
				minigame_timer_on = true;
				var password_index = 0;
				if(memory_game_index % 2 != 0){
					password_index = memory_game_index-1;
				}
				else{
					password_index = memory_game_index;
				}
				with(password1_txt_instance){
					drawing = true;
					input_text = [other.correct_game_passwords[password_index]];
					pos_x = display_get_gui_width()/2 - 100;
					pos_y = display_get_gui_height()/2-116;
					offset_x = 0;
					offset_y = 0;
					text_colour = c_black;
					text_font = fnt_rockwell_24px;
					calculate_string_width = false;
				}
				with(password2_txt_instance){
					drawing = true;
					input_text = [other.correct_game_passwords[password_index+1]];
					text_font = fnt_rockwell_24px;
					pos_x = display_get_gui_width()/2 - 100;
					pos_y = display_get_gui_height()/2+74;
					offset_x = 0;
					offset_y = 0;
					text_colour = c_black;
					calculate_string_width = false;
				}
			}//handle question viewing and generating
			else{
				var npc_names = ["Bob","Louise","Abby","Shane","Barry","Helen","John","Pat","Kerry","Mary"];
				var password1_pos_y = 0;
				var password2_pos_y = 0;
				if(chosen_question_index % 2){
					password1_pos_y = display_get_gui_height()/2-55;
					password2_pos_y = display_get_gui_height()/2+135;
				}
				else{
					password2_pos_y = display_get_gui_height()/2-55;
					password1_pos_y = display_get_gui_height()/2+135;
				}
				with(npc_profile_spr_instance){
					drawing = true;
					sprite_name = spr_characters;
					sprite_sub_image = other.chosen_question_index;
					pos_x = display_get_gui_width()/2 - 320;
					pos_y = display_get_gui_height()/2-30;
					xscale = 2;
					yscale = 2;
				}
				with(npc_name_txt_instance){
					drawing = true;
					input_text = [npc_names[other.chosen_question_index]];
					pos_x = display_get_gui_width()/2 - 252;
					pos_y = display_get_gui_height()/2+95;
					text_colour = c_black;
					text_font = fnt_rockwell_24px;
				}
				with(password1_txt_instance){
					drawing = true;
					input_text = [other.correct_game_passwords[other.chosen_question_index]];
					pos_x = display_get_gui_width()/2 - 30;
					pos_y = password1_pos_y;
					text_colour = c_black;
					text_font = fnt_rockwell_24px;
					calculate_string_width = false;
				}
				with(password2_txt_instance){
					drawing = true;
					input_text = [other.incorrect_game_passwords[other.chosen_question_index*2]];
					text_font = fnt_rockwell_24px;
					pos_x = display_get_gui_width()/2 - 30;
					pos_y = password2_pos_y;
					text_colour = c_black;
					calculate_string_width = false;
				}
			}				
			password1_txt_instance.alarm[0] = 2;
			password2_txt_instance.alarm[0] = 2;
			npc_name_txt_instance.alarm[0] = 2;		
			npc_profile_spr_instance.alarm[0] = 2;		
		}
	
		if(minigame_timer_on){
			var timer_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
			var display_text = "";
			if (string_length(string(floor(minigame_seconds / 60))) == 1) {
				display_text = display_text + "0" + string(floor(minigame_seconds / 60));
			} else {
				display_text = display_text + "" + string(floor(minigame_seconds / 60));
			}
			with(timer_txt_instance){
				drawing = true;
				input_text = [display_text];
				pos_x = display_get_gui_width()/2+30;
				pos_y = display_get_gui_height()/2 + 235;
				offset_x = 0;
				offset_y = 0;
				text_colour = c_black;
				text_font = fnt_rockwell_48px;
			}		
			timer_txt_instance.alarm[0] = 2;
		}
	
	
		with (obj_player){
			can_move = false;
			player_interacting = true;
		}

		with (obj_user_interface){
			draw_overlay = true;
			overlay_target = spr_memorise_game;
			overlay_sub_img = other.memory_game_index;
			overlay_scale_x = 2;
			overlay_scale_y = 2;
			offset_width = 1;
			offset_height = 1;
		}
	
		//player clicks up
		if(keyboard_check_pressed(global.controls[0].value)){
			if(memory_game_index == 11){
					memory_game_index -= 1;			
			}
		}
	
		//player clicks down
		if(keyboard_check_pressed(global.controls[1].value)){
			if(memory_game_index == 10){
					memory_game_index += 1;			
			}
		}
	
	
		//player clicks left
		if(keyboard_check_pressed(global.controls[2].value)){
			if(memory_game_index > 1 and memory_game_index < 9){
				//index is even
				if(memory_game_index % 2 == 0){
					memory_game_index += 1;
				}
			
			}
		}
	
		//player clicks right
		if(keyboard_check_pressed(global.controls[3].value)){
			show_debug_message(memory_game_index);
			if(memory_game_index > 1 and memory_game_index <= 9){
				//index is even
				if(memory_game_index % 2 != 0){
					memory_game_index -= 1;
				}
			
			}
		}
		
		if (!subtitles_triggered and minigame_seconds <= 0 and !timed_out) {
			timed_out = true;
			out_of_time = true;
			with (obj_user_interface) {
				subtitle_index = 0;
				dialog_index = 0;
				text_index = 0;                    
				typing_speed = 40; 
				dialog = ["You are out of time."];
				show_subtitles = true;
			}
			subtitles_triggered = true;
		}
	
		//player interacts
		if(keyboard_check_pressed(global.controls[4].value)){	
			if(out_of_time){
				subtitles_triggered = false;
				out_of_time = false;
				memory_question = true;
				minigame_timer_on = false;
				memory_game_index = 10;
				exit;
			}
			else if(subtitles_triggered and !out_of_time){ //reset game
				//keyboard_clear(global.controls[4].value);
				subtitles_triggered = false;
				obj_player.can_move = true
				obj_player.player_interacting = false;
				obj_user_interface.draw_overlay = false;
				memory_game_index = 0;
				minigame_timer_on = false;
				minigame_seconds = 60 * 60;
				if(timer_txt_instance != pointer_null){			
					if(instance_exists(timer_txt_instance)){
						instance_destroy(timer_txt_instance);
					}
				}
				passwords_generated = false;
				passwords_populated = false;
				incorrect_game_passwords = array_create(20, "");
				correct_game_passwords = array_create(10, "");
				game_started = false;
				memory_game_index = false;
				memory_question = false;
			}			
			else if (memory_game_index == 8){
				minigame_timer_on = false;
				memory_question = true;
				memory_game_index += 2;
			}
			else if (memory_game_index <= 9){
				if(memory_game_index <= 1){
					memory_game_index += 1;
				}
				else{			
					if (memory_game_index % 2 == 0){
						memory_game_index += 2;
					}
					else{
						memory_game_index -= 2;
					}
				}
			}
			else{ //player answering question logic
				if(chosen_question_index % 2){
					//player answers correctly
					if(memory_game_index == 10){
						task_completed = true;
					}//player incorrect. Reset game
					else{
						if (!subtitles_triggered) {
							obj_player.can_move = false;
							with (obj_user_interface) {
								subtitle_index = 0;
								dialog_index = 0;
								text_index = 0;                    
								typing_speed = 40; 
							    dialog = ["You have selected the wrong password!"];
							    show_subtitles = true;
							}
							subtitles_triggered = true;
						}
					}
				}
				else{
					//player answers correctly
					if(memory_game_index == 11){
						task_completed = true;
					}//player incorrect. Reset game
					else{
						if (!subtitles_triggered) {
							obj_player.can_move = false;
							with (obj_user_interface) {
								subtitle_index = 0;
								dialog_index = 0;
								text_index = 0;                    
								typing_speed = 40; 
							    dialog = ["You have selected the wrong password!"];
							    show_subtitles = true;
							}
							subtitles_triggered = true;
						}
					}
				}
			}
		}
	
		if(keyboard_check_pressed(global.controls[5].value) and !task_completed and !obj_user_interface.show_subtitles){ //checks if player exits
			obj_player.can_move = true
			obj_player.player_interacting = false;
			obj_user_interface.draw_overlay = false;
			memory_game_index = 0;
			minigame_timer_on = false;
			minigame_seconds = 60 * 60;
			if(timer_txt_instance != pointer_null){			
				if(instance_exists(timer_txt_instance)){
					instance_destroy(timer_txt_instance);
				}
			}
			passwords_generated = false;
			passwords_populated = false;
			incorrect_game_passwords = array_create(20, "");
			correct_game_passwords = array_create(10, "");
			game_started = false;
			memory_game_index = false;
			memory_question = false;
		}
	}
	else if(task_completed){
		obj_user_interface.draw_overlay = false;
		camera_set_view_target(view_camera[0], obj_camera);
		with(obj_camera){
			enabled = true;
			puzzle_completed = true;
			starting_pos_x = obj_player.x;
			starting_pos_y = obj_player.y;
			end_pos_x = obj_door.x;
			end_pos_y = obj_door.y;
		}
		//renables player movement after 7 seconds
		alarm[0] = 60*7;
		//turns tv off
		obj_memorise_game.image_index = 0;
		//exit;
		obj_player.player_interacting = false;
	}
	else{
		//shows player the tv is off
		if (!subtitles_triggered and !subtitles_recently_closed) {
		    with (obj_user_interface) {
				subtitle_index = 0;
				dialog_index = 0;
				text_index = 0;                    
				typing_speed = 40; 
		        dialog = ["The TV is currently off."];
		        show_subtitles = true;
		    }
		    subtitles_triggered = true;
		}

		//checks for subittles being finished
		if (!obj_user_interface.show_subtitles) { 
		    obj_player.player_interacting = false;
		    obj_player.can_move = true;

		    //prevent subtitle retriggering loop
		    subtitles_triggered = false;
		    subtitles_recently_closed = true;
		}

		//allows subtitles for next interaction
		if (obj_player.can_move and !keyboard_check(global.controls[4].value)) {
		    subtitles_recently_closed = false;
		}

	}
}