/// @description Player Movement, Collisions, Transitions, Room_Depth, Interactions


if(room == rm_end) {
	exit;
}

//keyboard controls
var input_left = keyboard_check(global.controls[2].value);
var input_right = keyboard_check(global.controls[3].value);
var input_up = keyboard_check(global.controls[0].value);
var input_down = keyboard_check(global.controls[1].value);

//intended movement variables
var move_x = 0;
var move_y = 0;

//enables/disables player movement
if (can_move){
	//intended movement
	move_x = (input_right - input_left) * player_move_speed;
	if(move_x == 0) move_y = (input_down - input_up) * player_move_speed;
	//get direction player is facing
	if(move_x != 0){
		switch(sign(move_x)){
			case 1: facing = dir.right; last_facing = dir.right break;
			case -1: facing = dir.left; last_facing = dir.left break;
		}
	}
	else if(move_y != 0){
		switch(sign(move_y)){
			case 1: facing = dir.down; last_facing = dir.down break;
			case -1: facing = dir.up; last_facing = dir.up break;
		}
	}
	else{
		facing = -1;
	}
}

//Check Collision
var collision_objects = [obj_collision, obj_collision_circle, obj_door_lock];
if (move_x != 0) {
	for (var i = 0; i < array_length(collision_objects); i++) {
	    if (place_meeting(x + move_x, y, collision_objects[i])) {
	        repeat(abs(move_x)) {
	            if (!place_meeting(x + sign(move_x), y, collision_objects[i])) {
	                x += sign(move_x);
	            } else {
	                break;
	            }
	        }
	        move_x = 0;
	    }
	}
}
if (move_y != 0) {
	for (var i = 0; i < array_length(collision_objects); i++) {
	    if (place_meeting(x, y + move_y, collision_objects[i])) {
	        repeat(abs(move_y)) {
	            if (!place_meeting(x, y + sign(move_y), collision_objects[i])) {
	                y += sign(move_y);
	            } else {
	                break;
	            }
	        }
	        move_y = 0;
	    }
	}
}

//Check Transition
var transition_inst = instance_place(x, y, obj_transition); //returns an id or noone
if(transition_inst != noone){
	with(obj_game){
		do_transition = true;
		target_room = transition_inst.target_room;
		spawn_direction = transition_inst.target_direction;
	}
	exit;
}

var alpha_change_inst = instance_place(x,y, obj_room_depth);
var adjust_layer_visability = false;
if(alpha_change_inst != noone){
	if(alpha_change_inst.allow_change){
		layer_depth("Object_Highlighting", layer_get_depth("Above_Side_Walls")-100);
	}
	adjust_layer_visability = true;
	if(room == rm_escape_room) obj_memorise_game.depth = layer_get_depth(layer_get_id("Above_Side_Walls")) - 100;
}
else{
	layer_depth("Object_Highlighting", layer_get_depth("Interactions")+99);
	adjust_layer_visability = false;
	if(room == rm_escape_room) obj_memorise_game.depth = obj_player.depth + 100;
}

if(layer_exists("Above_Front_Walls")) layer_set_visible("Above_Front_Walls" , adjust_layer_visability);
if(layer_exists("Above_Front_Walls_Decorations")) layer_set_visible("Above_Front_Walls_Decorations" , adjust_layer_visability);
if(layer_exists("Above_Front_Wall_Objects")) layer_set_visible("Above_Front_Wall_Objects", adjust_layer_visability);
if(layer_exists("Above_Furniture")) layer_set_visible("Above_Furniture" , adjust_layer_visability);
if(layer_exists("Above_Furniture_Decorations")) layer_set_visible("Above_Furniture_Decorations" , adjust_layer_visability);
if(layer_exists("Above_Side_Walls")) layer_set_visible("Above_Side_Walls" , adjust_layer_visability);

//Check Interaction
var interaction_list = ds_list_create();
//gets all obj_interaction instances
instance_place_list(x,y,obj_interaction,interaction_list, false);

//if object is deleted - a task is completed handle reassignment
if (!instance_exists(last_interactable_obj)){
	last_interactable_obj = noone;
}

//remove previous highlighting of object
if(last_interactable_obj != noone){
	last_interactable_obj.highlight_visible = false;
	last_interactable_obj.update_highlighting();
	last_interactable_obj = noone;
}

//gets the current interactable object the player is facing. This means overlapping objects will be selected by player direction.
for(var i = 0; i < ds_list_size(interaction_list);i++){
	var interact_inst = interaction_list[| i]; //get instance at current index
	if (interact_inst != noone and last_facing == interact_inst.facing) {
		last_interactable_obj = interact_inst;
	}
}

//handles enabling object highlighting and interacting with the object
if (last_interactable_obj != noone and last_facing == last_interactable_obj.facing and !last_interactable_obj.task_completed) {		
	last_interactable_obj.highlight_visible = true;
	last_interactable_obj.update_highlighting();
	if (keyboard_check(global.controls[4].value) and !player_interacting){
		keyboard_clear(global.controls[4].value);
		player_interacting = true;
		last_interactable_obj.interact();
	}
	else if(variable_instance_exists(last_interactable_obj, "disable_interact_button")){
		if(last_interactable_obj.disable_interact_button and !player_interacting){
			player_interacting = true;
			last_interactable_obj.interact();
		}
	}
}

//continue interacting
if(player_interacting and last_interactable_obj != noone and !obj_game.game_paused){	
	last_interactable_obj.interact();
}

//list destroyed to prevent memory issues
ds_list_destroy(interaction_list);

//input player direction
x += move_x;
y += move_y;