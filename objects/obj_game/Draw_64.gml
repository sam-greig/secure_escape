/// @description Room fade transition

//FADE Between room transitions
if(do_transition){
	if(instance_exists(obj_player)){
		io_clear();
		obj_player.can_move = false;
	}
	//fade to room
	if(room != target_room){
		fade_alpha += 0.05;
		if(fade_alpha >= 1){
			room_goto(target_room);
		}
	}//once in room remove fade
	else{
		fade_alpha -= 0.05;
		if(fade_alpha <=0){
			do_transition = false;
			if(instance_exists(obj_player)){
				obj_player.can_move = true;
			}
		}
	}	
	//draw fade
	draw_set_alpha(fade_alpha);
	draw_rectangle_color(0,0,width,height,c_black,c_black,c_black,c_black,false);
	draw_set_alpha(1);
}