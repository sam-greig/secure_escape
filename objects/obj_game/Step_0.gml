/// @description Insert description here

if(debug){
	if(keyboard_check_pressed(ord("R"))){game_restart();} //game restart
}

if(room == rm_start){
	if(!confirm_quit and !show_settings and !confirm_tutorial and !obj_game.do_transition){
		//player presses up
		if (keyboard_check_pressed(global.controls[0].value)){
			if(pause_index > 0){
				pause_index -= 1;
				obj_title_screen.image_index -= 1;
			}
		}
	
		//player presses down
		if (keyboard_check_pressed(global.controls[1].value)){
			if(pause_index < 2){
				pause_index += 1;
				obj_title_screen.image_index += 1;
			}
		}
	
		//player presses interact
		if (keyboard_check_pressed(global.controls[4].value)){
			switch(pause_index){
				case 0: 
					keyboard_clear(global.controls[4].value);
					confirm_tutorial = true;
					//do_transition = true;
					//target_room = rm_tutorial;
					break;
				case 1:
					keyboard_clear(global.controls[4].value);
					show_settings = true;
					pause_index = 0;
					break;
				case 2:
					keyboard_clear(global.controls[4].value);
					confirm_quit = true;
					pause_index = 1;
					break;
			}
		}
	}
	//check if player wants to view tutorial
	if(confirm_tutorial){
		//move left
		if (keyboard_check_pressed(global.controls[2].value)){
			keyboard_clear(global.controls[2].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
		//move right
		if (keyboard_check_pressed(global.controls[3].value)){
			keyboard_clear(global.controls[3].value);
			if(pause_index < 1){
				pause_index += 1;
			}
		}
		//interact or leave key pressed
		if (keyboard_check_pressed(global.controls[4].value) or keyboard_check_pressed(global.controls[5].value)){
			keyboard_clear(global.controls[4].value);
			//leave key pressed
			if (keyboard_check_pressed(global.controls[5].value)){
				keyboard_clear(global.controls[5].value);//reset key
				pause_index = 0;
				confirm_tutorial = false;
				obj_user_interface.draw_overlay = false;
				exit;
			}
			//yes selected
			if (pause_index == 0){
				do_transition = true;
				target_room = rm_tutorial;
				spawn_direction = dir.up;
				confirm_tutorial = false;
				obj_user_interface.draw_overlay = false;
				exit;
			}
			else{
				pause_index = 0;
				do_transition = true;
				target_room = rm_escape_room;
				spawn_direction = dir.down;
				confirm_tutorial = false;
				obj_user_interface.draw_overlay = false;
				exit;
			}
		}
		if(confirm_tutorial){
			with(obj_user_interface){
				overlay_target = spr_tutorial_confirm;
				overlay_sub_img = obj_game.pause_index;
				overlay_scale_x = 2;
				overlay_scale_y = 2;
				offset_width = 1;
				offset_height = 1;
				draw_overlay = true;
			}
		}
	}//if the player is about to fully quit the game
	else if(confirm_quit){
		//move left
		if (keyboard_check_pressed(global.controls[2].value)){
			keyboard_clear(global.controls[2].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
		//move right
		if (keyboard_check_pressed(global.controls[3].value)){
			keyboard_clear(global.controls[3].value);
			if(pause_index < 1){
				pause_index += 1;
			}
		}
		//interact or leave key pressed
		if (keyboard_check_pressed(global.controls[4].value) or keyboard_check_pressed(global.controls[5].value)){
			keyboard_clear(global.controls[4].value);
			//leave key pressed
			if (keyboard_check_pressed(global.controls[5].value)){
				keyboard_clear(global.controls[5].value);//reset key
				pause_index = 1;
			}
			//yes selected
			if (pause_index == 0){
				game_end();
			}
			else{
				//reset to previous screen
				confirm_quit = false;
				pause_index = 2;
				obj_user_interface.draw_overlay = false;
			}
		}
		if(confirm_quit){
			with(obj_user_interface){
				overlay_target = spr_quit_confirm;
				overlay_sub_img = obj_game.pause_index;
				overlay_scale_x = 2;
				overlay_scale_y = 2;
				offset_width = 1;
				offset_height = 1;
				draw_overlay = true;
			}
		}
		
	}//view the settings
	else if(show_settings){		
		//converts all curent assigned controls to an array of strings
		var drawn_controls = [];
		for (var i = 0; i < array_length(global.controls); i++) {
			array_push(drawn_controls, get_key_text(global.controls[i].value));
		}
		
		//change keybinds
		if (change_key) {
			drawn_controls[pause_index-1] = ""; //removes text of currently selected index			
			if (keyboard_check_pressed(vk_anykey)) {
				var invalid_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
				//checks if a valid key is selected and no duplicate key is entered
			    if (get_key_text(keyboard_lastkey) != "Invalid Key" and !array_contains(drawn_controls, get_key_text(keyboard_lastkey))) {
					with (obj_draw_text) {
				        for (var i = 0; i < array_length(input_text); i++) {
				            if (input_text[i] == "Invalid Key") {
								instance_destroy();		
				            }
				        }
				    }
			        global.controls[pause_index - 1].value = keyboard_lastkey;
					io_clear();
					change_key = false;
			    }
				else{
					//invalid key - displays feedback to player
					with(invalid_txt_instance){
						drawing = true;
						input_text = ["Invalid Key"];
						text_colour = c_red;
						pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
						pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105 + ((other.pause_index-1) * 95); //adjusts the y to the correct index
						offset_x = 0;
						offset_y = 0;
					}
					invalid_txt_instance.alarm[0] = 60*2;
				}
			    io_clear();
			}
			else{
				//prompts user to enter a key
				var exists = false;
			    with (obj_draw_text) {
			        for (var i = 0; i < array_length(input_text); i++) {
			            if (input_text[i] == "Press Key" or input_text[i] == "Invalid Key") {
			                exists = true;
			                break;
			            }
			        }
			    }
				if(!exists){
					var txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
					with(txt_instance){
						drawing = true;
						input_text = ["Press Key"];
						text_colour = c_green;
						pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
						pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105 + ((other.pause_index-1) * 95);
						offset_x = 0;
						offset_y = 0;
					}
					show_debug_message(((other.pause_index-1) * 95));
					txt_instance.alarm[0] = 1;
				}
			}
		}
		
		var controls_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
		//draw controls
		with(controls_txt_instance){
			drawing = true;
			input_text = drawn_controls;
			text_colour = c_black;
			pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
			pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105;
			offset_x = 0;
			offset_y = 95;
		}
		controls_txt_instance.alarm[0] = 2;
		if (keyboard_check_pressed(global.controls[0].value)){
			keyboard_clear(global.controls[0].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
		
		if (keyboard_check_pressed(global.controls[1].value)){
			keyboard_clear(global.controls[1].value);
			if (pause_index < 6){
				pause_index += 1;
			}
		}
		
		if((keyboard_check_pressed(global.controls[4].value) and pause_index == 0) or keyboard_check_pressed(global.controls[5].value)){
			keyboard_clear(global.controls[4].value);//reset key
			keyboard_clear(global.controls[5].value);//reset key
			controls_txt_instance.drawing = false;
			show_settings = false;
			pause_index = 1;
			obj_user_interface.draw_overlay = false;
		}		
		else if(keyboard_check_pressed(global.controls[4].value)){
			keyboard_clear(global.controls[4].value);//reset key
			change_key = true;
		}
		if(show_settings){
			with(obj_user_interface){
				overlay_target = spr_settings;
				overlay_sub_img = obj_game.pause_index;
				overlay_scale_x = 2;
				overlay_scale_y = 2;
				offset_width = 1;
				offset_height = 1;
				draw_overlay = true;
			}
		}
	}
	//prevents further code being ran
	exit;
}
//game pause menu is brought up if the assigned leave button is pressed
if(!obj_player.player_interacting and !game_paused and keyboard_check_pressed(global.controls[5].value)){
	if(object_exists(obj_camera)){
		if(!obj_camera.enabled){
			game_paused = true;
		}
	}
	keyboard_clear(global.controls[5].value); //reset key
}

//game paused
if(game_paused){
	var selected_sprite = spr_pause_screen;
	//update player object
	with(obj_player){
		player_interacting = true;
		can_move = false;
	}
	
	//if the user is about to fully quit the game
	if(confirm_quit){
		selected_sprite = spr_quit_confirm;
		//move left
		if (keyboard_check_pressed(global.controls[2].value)){
			keyboard_clear(global.controls[2].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
		//move right
		if (keyboard_check_pressed(global.controls[3].value)){
			keyboard_clear(global.controls[3].value);
			if(pause_index < 1){
				pause_index += 1;
			}
		}
		//interact or leave key pressed
		if (keyboard_check_pressed(global.controls[4].value) or keyboard_check_pressed(global.controls[5].value)){
			keyboard_clear(global.controls[4].value);
			//leave key pressed
			if (keyboard_check_pressed(global.controls[5].value)){
				keyboard_clear(global.controls[5].value);//reset key
				pause_index = 1;
			}
			//yes selected
			if (pause_index == 0){
				game_end();
			}
			else{
				//reset to previous screen
				confirm_quit = false;
				pause_index = 2;
				selected_sprite = spr_pause_screen;
			}
		}
		
	}//view the settings
	else if(show_settings){
		selected_sprite = spr_settings;
		
		//converts all curent assigned controls to an array of strings
		var drawn_controls = [];
		for (var i = 0; i < array_length(global.controls); i++) {
			array_push(drawn_controls, get_key_text(global.controls[i].value));
		}
		
		//change keybinds
		if (change_key) {
			drawn_controls[pause_index-1] = ""; //removes text of currently selected index			
			if (keyboard_check_pressed(vk_anykey)) {
				var invalid_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
				//checks if a valid key is selected and no duplicate key is entered
			    if (get_key_text(keyboard_lastkey) != "Invalid Key" and !array_contains(drawn_controls, get_key_text(keyboard_lastkey))) {
					with (obj_draw_text) {
				        for (var i = 0; i < array_length(input_text); i++) {
				            if (input_text[i] == "Invalid Key") {
								instance_destroy();		
				            }
				        }
				    }
			        global.controls[pause_index - 1].value = keyboard_lastkey;
					io_clear();
					change_key = false;
			    }
				else{
					//invalid key - displays feedback to player
					with(invalid_txt_instance){
						drawing = true;
						input_text = ["Invalid Key"];
						text_colour = c_red;
						pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
						pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105 + ((other.pause_index-1) * 95); //adjusts the y to the correct index
						offset_x = 0;
						offset_y = 0;
					}
					invalid_txt_instance.alarm[0] = 60*2;
				}
			    io_clear();
			}
			else{
				//prompts user to enter a key
				var exists = false;
			    with (obj_draw_text) {
			        for (var i = 0; i < array_length(input_text); i++) {
			            if (input_text[i] == "Press Key" or input_text[i] == "Invalid Key") {
			                exists = true;
			                break;
			            }
			        }
			    }
				if(!exists){
					var txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
					with(txt_instance){
						drawing = true;
						input_text = ["Press Key"];
						text_colour = c_green;
						pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
						pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105 + ((other.pause_index-1) * 95);
						offset_x = 0;
						offset_y = 0;
					}
					show_debug_message(((other.pause_index-1) * 95));
					txt_instance.alarm[0] = 1;
				}
			}
		}
		
		var controls_txt_instance = instance_create_depth(x, y, 0, obj_draw_text);
		//draw controls
		with(controls_txt_instance){
			drawing = true;
			input_text = drawn_controls;
			text_colour = c_black;
			pos_x = display_get_gui_height()/2+sprite_get_width(spr_settings) + 160;
			pos_y = display_get_gui_width()/2-sprite_get_height(spr_settings)*2 + 105;
			offset_x = 0;
			offset_y = 95;
		}
		controls_txt_instance.alarm[0] = 2;
		if (keyboard_check_pressed(global.controls[0].value)){
			keyboard_clear(global.controls[0].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
		
		if (keyboard_check_pressed(global.controls[1].value)){
			keyboard_clear(global.controls[1].value);
			if (pause_index < 6){
				pause_index += 1;
			}
		}
		
		if((keyboard_check_pressed(global.controls[4].value) and pause_index == 0) or keyboard_check_pressed(global.controls[5].value)){
			keyboard_clear(global.controls[4].value);//reset key
			keyboard_clear(global.controls[5].value);//reset key
			controls_txt_instance.drawing = false;
			show_settings = false;
			pause_index = 1;
			selected_sprite = spr_pause_screen;
		}		
		else if(keyboard_check_pressed(global.controls[4].value)){
			keyboard_clear(global.controls[4].value);//reset key
			change_key = true;
		}
	}
	else{	
		//disable timer and display pause menu
		if (keyboard_check_pressed(global.controls[0].value)){
			keyboard_clear(global.controls[0].value);
			if (pause_index > 0){
				pause_index -= 1;
			}
		}
	
		if (keyboard_check_pressed(global.controls[1].value)){
			keyboard_clear(global.controls[1].value);
			if(pause_index < 2){
				pause_index += 1;
			}
		}
		var resume_game = false;
		if (keyboard_check_pressed(global.controls[4].value)){
			keyboard_clear(global.controls[4].value);
			if (pause_index == 1){
				show_settings = true;
				pause_index = 1;
				exit;
			}
			else if (pause_index == 2){
				confirm_quit = true;
				pause_index = 1;
				exit;
			}
			else{
				resume_game = true;
			}
		}	
	
		//user resumes game
		if (keyboard_check_pressed(global.controls[5].value) or resume_game){
			keyboard_clear(global.controls[4].value);
			keyboard_clear(global.controls[5].value);
			with(obj_user_interface){
				draw_overlay = false;
				if(!other.door_unlocked and room == rm_escape_room){
					timer_on = true;
				}
			}
			game_paused = false;
			with(obj_player){
				player_interacting = false;
				can_move = true;
			}
			pause_index = 0;
		}
	}
	
	//draw overlay
	if(game_paused){
		with(obj_user_interface){
			timer_on = false;
			overlay_target = selected_sprite;
			overlay_sub_img = obj_game.pause_index;
			overlay_scale_x = 2;
			overlay_scale_y = 2;
			offset_width = 1;
			offset_height = 1;
			draw_overlay = true;
		}
	}
	
}

//handles player running out of time
if(obj_user_interface.mins == 0 and obj_user_interface.seconds == 0 and !out_of_time){
	out_of_time = true;
	obj_player.player_interacting = false;
	obj_user_interface.draw_overlay = false;
	obj_user_interface.show_subtitles = false;
	with(obj_draw_text){
		instance_destroy();
	}
	with(obj_draw_sprite){
		instance_destroy();
	}
	with(obj_interaction){
		instance_destroy();
	}
	do_transition = true;
	target_room = rm_end;
}

if(room == rm_end){
	//user interface overlay always drawn ontop
	obj_user_interface.depth = -1000; 
	if(!credits_concluded){
		var starting_time, ending_time, diff_min, diff_sec = 0;
		if(!out_of_time){
			//time converted to seconds
			starting_time = (obj_user_interface.starting_mins * 60) + (obj_user_interface.starting_seconds/60);
			ending_time = (obj_user_interface.mins * 60) + (obj_user_interface.seconds/60);
			//get the difference in times
			var time_diff = abs(starting_time - ending_time);
			//seperate them into mins and seconds
			diff_min = time_diff div 60;
			diff_sec = ceil(time_diff mod 60);
			if(!(diff_sec % 60)){
				diff_min += 1;
				diff_sec = 0;
			}
		}
		
		var inst_end_time = instance_create_depth(x, y, layer_get_depth("Front_Walls")-100, obj_draw_text);
		with(inst_end_time){
			drawing = true;
			if(other.out_of_time){
				input_text = ["Unlucky, you did not escape!",
							  "Good luck next time."];
			}
			else{
				input_text = ["Congrats, you escaped!",
							  "It took you "+string(diff_min)+"mins "+string(diff_sec) +"secs to escape."];
			}
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_32px;
		}
		inst_end_time.alarm[0] = 2;
	
		var inst_credits = instance_create_depth(x, y, layer_get_depth("Front_Walls")-100, obj_draw_text);
		with(inst_credits){
			drawing = true;
			input_text = ["Credits"];
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y+400;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_32px;
		}
		inst_credits.alarm[0] = 2;
	
		var inst_art_credits_title = instance_create_depth(x, y, layer_get_depth("Front_Walls")-100, obj_draw_text);
		with(inst_art_credits_title){
			drawing = true;
			input_text = [
			"Art"];
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y+500;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_32px;
		}
		inst_art_credits_title.alarm[0] = 2;
	
		var inst_art_credits = instance_create_depth(x, y, layer_get_depth("Front_Walls")-100, obj_draw_text);
		with(inst_art_credits){
			drawing = true;
			input_text = [
			"Cats Pixel Art by Zuhal", 
			"Cool School Tileset by NettySvit", 
			"LPC House Insides by Lanea Zimmerman",
			"Character Assets by makrohn"];
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y+575;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_24px;
		}
		inst_art_credits.alarm[0] = 2;
	
		var inst_special_thanks_title = instance_create_depth(x, y, 0, obj_draw_text);
		with(inst_special_thanks_title){
			drawing = true;
			input_text = [
			"Special Thanks"];
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y+950;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_32px;
		}
		inst_special_thanks_title.alarm[0] = 2;
	
	
		var inst_special_thanks_items = instance_create_depth(x, y, 0, obj_draw_text);
		with(inst_special_thanks_items){
			drawing = true;
			input_text = [
			"Rosanne English",
			"FriendlyCosmonaut (GameMaker Tutorials)",
			"Artists from OpenGameArt",
			"All the amazing game testers!"];
			pos_x = display_get_gui_width()/2;
			pos_y = other.starting_y+1025;
			offset_x = 0;
			offset_y = 50;
			text_colour = c_black;
			text_font = fnt_rockwell_24px;
		}
		inst_special_thanks_items.alarm[0] = 2;
	}
	
	var inst_title = instance_create_depth(x, y, 0, obj_draw_text);
	with(inst_title){
		drawing = true;
		input_text = [
		"Secure Escape"
		];
		pos_x = display_get_gui_width()/2;
		if(other.starting_y+1600 > display_get_gui_height()/2-250){
			pos_y = other.starting_y+1600;
		}
		else{
			pos_y = display_get_gui_height()/2-250;
		}
		offset_x = 0;
		offset_y = 50;
		text_colour = c_black;
		text_font = fnt_rockwell_48px;
	}
	inst_title.alarm[0] = 2;
	
	
	var inst_created_by = instance_create_depth(x, y, 0, obj_draw_text);
	with(inst_created_by){
		drawing = true;
		input_text = [
		"Created by Sam Greig",
		"Thank you so much for playing! :)"
		];
		pos_x = display_get_gui_width()/2;
		if(other.starting_y+1700 > display_get_gui_height()/2-25){
			pos_y = other.starting_y+1700;
		}
		else{
			pos_y = display_get_gui_height()/2-25;
		}
		offset_x = 0;
		offset_y = 50;
		text_colour = c_black;
		text_font = fnt_rockwell_24px;
	}
	inst_created_by.alarm[0] = 2;
	
	var inst_olive = instance_create_depth(x, y, 0, obj_draw_sprite);
	with(inst_olive){
		drawing = true;
		sprite_name = spr_olive;
		sprite_sub_image = 0;
	    pos_x = display_get_gui_width() / 2 - (sprite_get_width(spr_olive) * xscale);
	    if (other.starting_y + 1850 - sprite_get_height(spr_olive) > display_get_gui_height() / 2 - (sprite_get_height(spr_olive) * yscale) / 2+100) {
	        credits_concluded = true;
	        pos_y = other.starting_y + 1850 - sprite_get_height(spr_olive);
	    } else {
	        pos_y = display_get_gui_height() / 2 - (sprite_get_height(spr_olive) * yscale) / 2+100;
	    }		
		xscale = 2;
		yscale = 2;
		rot = 0;
		sprite_colour = c_white;
		alpha = 1;
	}
	inst_olive.alarm[0] = 2;
	
	if(!game_paused){
		starting_y -= 2;
	}
}