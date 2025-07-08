/// @description Insert description here
// You can write your code in this editor


if (enabled) {
    //total x and y distance between the current postion and the end position
    var pos_x = end_pos_x - x;
    var pos_y = end_pos_y - y;    
    //distance between target
    var dist = point_distance(x, y, end_pos_x, end_pos_y); 
    //camera pan speed
    var camera_speed = 3;
    //arrived near destination
    if (dist < 2) {
        x = end_pos_x;
        y = end_pos_y;
    } else {
        //move towards target
        x += pos_x * (camera_speed / dist);
        y += pos_y * (camera_speed / dist);
    }

	//arrived at destination
    if (abs(pos_x) == 0 and abs(pos_y) == 0 and !arrived) {
		//update global variables
		if(puzzle_completed){
			obj_game.door_keys_required -= 1;
			obj_door_lock_visualisation.image_index += 1;
		}
		//reset booleans
		puzzle_completed = false;
		arrived = true;
		//timer to reset back to player
        alarm[0] = 60*1.5;
    }
}
else {
    //when not moving camera defaults back to the player
    if (instance_exists(obj_player)) {
        x = lerp(x, obj_player.x, 0.05);
        y = lerp(y, obj_player.y, 0.05);
    }
}

