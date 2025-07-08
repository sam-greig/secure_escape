/// @description Timers


if(minigame_timer_on){
	if (minigame_seconds > 0){		
		minigame_seconds -= 1;
	}
	else if (minigame_seconds <= 0 and minigame_mins > 0){
		minigame_mins -= 1;
		minigame_seconds = 60 * 60;
	}
}




