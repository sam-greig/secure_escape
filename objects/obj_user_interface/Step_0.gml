/// @description 

//handles escape room timer
if(timer_on){ //room speed is 60fps - 60 steps = 1 second 
	if (seconds > 0){		
		seconds -= 1;
	}
	else if (seconds <= 0 and mins > 0){
		mins -= 1;
		seconds = 60 * 60;
	}	
}

//Handles displaying subtitles
if(show_subtitles){
	obj_player.can_move = false;
	//get text at index
	text = dialog[subtitle_index];
	
	//handles text display speed
	if (text_index < string_length(text)) {	
		//resets keyboard input for eneter key
		if(!keyboard_reset){
			keyboard_reset = true;
		}
		//if user clicks enter the full text is displayed. Else text slowly displayed.
		if (keyboard_check_pressed(global.controls[4].value)) {
	        text_index = string_length(text);
	    } else {
			text_index += typing_speed / 60;
	    }
	}
	else{
		//Handles exit out of subtitle.
		if(keyboard_check_pressed(global.controls[4].value)){
			show_subtitles = false; //clears previous subtitles
			if(dialog_index > 0 and subtitle_index+1 < array_length(dialog)){ //if more dialog to show
				dialog_index -= 1; //counter lines of dialog to show
				text_index = 0; //reset
				subtitle_index += 1; //index of dialog line
				keyboard_reset = false; //flag to false
				show_subtitles = true; //flag to begin next subtitle
			}
		}
	}
}




