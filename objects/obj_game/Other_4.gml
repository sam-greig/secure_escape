/// @description

//timer starts upon entering escape room.
if(room == rm_escape_room){
	alarm[0] = 60 * 1;
}
else if(room == rm_tutorial){
	keyboard_key_press(global.controls[0].value);
}

//Handle Player room spawnpoint
if(target_room == -1) exit;
obj_player.facing = spawn_direction;

 //this is needed due to order of events. 
 //draw event has the user as idle so this updates that.
with(obj_player){
	switch(facing){
		//update strip frame for player spawn direction
		case dir.left: y_frame = 9; break; //moving
		case dir.right: y_frame = 11; break; //right
		case dir.up: y_frame = 8; break;//up
		case dir.down: y_frame = 10; break;//down
		case -1: x_frame = 0; break; // player idle
	}
}