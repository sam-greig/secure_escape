/// @description Insert description here
// You can write your code in this editor

highlight_index = 0;
pos_x = 784;
pos_y = 49;
facing = dir.up;
task_completed = false;

//selection variables
selected_index = 0;
selected_column = 0;
selected_row = 0;  
subtitles_triggered = true;
current_overlay = spr_social_media_board;
displaying_post = false;

function interact() {	
	//prevent subtitles being triggered more than once.
	if(!subtitles_triggered){
		with(obj_user_interface){
			dialog_index = 4;
			show_subtitles = true;			
		}
		subtitles_triggered = true;		
	}	
	
	if(!obj_user_interface.show_subtitles){	
		//set overlay parameters
		with(obj_user_interface){
			overlay_target = other.current_overlay;
			overlay_sub_img = 0;
			overlay_scale_x = 2;
			overlay_scale_y = 2;
			offset_width = 1;
			offset_height = 1;
			draw_overlay = true;
		}
	
		obj_player.can_move = false; //disables player movement
		obj_player.player_interacting = true; //player is currently interacting
		
		if(!displaying_post){
			if(keyboard_check_pressed(global.controls[5].value)){ //checks if player exits
				keyboard_clear(global.controls[5].value);
				//update flags
				obj_player.can_move = true
				obj_player.player_interacting = false;
				obj_user_interface.draw_overlay = false;
				//reset index variables
				selected_index = 0;
				selected_column = 0;
				selected_row = 0;  				
			}
	
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
					if (selected_row+1 <= 2){
						selected_row += 1;
						selected_index += 3;
					}
			}
			//view current selected social media post
			if(keyboard_check_pressed(global.controls[4].value)){
					displaying_post = true;
					current_overlay = spr_social_media_posts;
			}
		}
		else{
			//player exits viewing a post
			if(keyboard_check_pressed(global.controls[5].value)){
				keyboard_clear(global.controls[5].value);
				displaying_post = false;
				current_overlay = spr_social_media_board;
			}
		}
		//update sub_image index
		obj_user_interface.overlay_sub_img = selected_index;
	}
}
