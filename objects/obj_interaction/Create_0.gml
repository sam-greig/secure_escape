/// @description 

//highlight variables
highlight_index = 0;
pos_x = 0;
pos_y = 0;
highlight_visible = false;

//overlay and interaction variables
task_completed = false;
facing = dir.up;
disable_input = false;

//minigame timer variables
minigame_timer_on = false;
minigame_mins = 0;
minigame_seconds = 0;

end_obj = obj_door;

function interact(){}


function update_highlighting(){
	with (obj_highlighting){
		image_index = other.highlight_index;
		x = other.pos_x;
		y = other.pos_y;
		visible = other.highlight_visible;
	}
}