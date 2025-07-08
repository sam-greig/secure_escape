/// @description



//opens game in fullscreen - Note: does not work if an always on top application is on top.
window_set_fullscreen(true);
//GUI adjusted to be the same as the display.
//display_set_gui_maximize();
display_set_gui_size(1920,1080); //set to be same resolution as developed on. (Means different resolution devices aren't affected by objects using display_get_gui())
//adjusts the surface so pixelart is not stretched
width = display_get_width();
height = display_get_height();
surface_resize(application_surface, width, height);

//hides mouse cursor
window_set_cursor(cr_none);
//ensure true randomness. -- applies to randomness of password generation
randomize();
room_goto_next();

//developer debug mode
debug = false;

if(debug){
	show_debug_message("Game loaded in: " + string(get_timer()/1000000) +"seconds");
}

//room transition variables
fade_alpha = 0;
target_room = -1;
spawn_direction = dir.up;
do_transition = false;

//game variables
door_keys_required = 3;
door_unlocked = false;
starting_y = display_get_gui_height()+300;
out_of_time = false;
credits_concluded = false;

//game pause variables
game_paused = false;
pause_index = 0;
confirm_tutorial = false;
confirm_quit = false;
show_settings = false;
change_key = false;

//global variable for all game controls
global.controls = [
    {name: "move_up", value: vk_up},
    {name: "move_down", value: vk_down},
    {name: "move_left", value: vk_left},
    {name: "move_right", value: vk_right},
    {name: "interactable", value: vk_enter},
    {name: "leave", value: vk_escape}
];

enum dir{ //enum is a global variable
	right = 0,
	up = 90,
	left = 180,
	down = 270,
}

function get_key_text(key_name){
	var key_string = "";
	
	//if lastkey is a number or letter
	if (real(key_name) >= 48 and real(key_name) <= 90){
		key_string = chr(key_name);
	}
	else{	
		switch (key_name) {
			//ordered by ASCII value
		    case vk_backspace: key_string = "Backspace"; break;
		    case vk_tab: key_string = "Tab"; break;
		    case 12: key_string = "Npad 5"; break; //num lock off
			case 16: key_string = "Shift"; break; //covers both shift keys
		    case vk_enter: key_string = "Enter"; break;
		    //case vk_pause: key_string = "Pause"; break; //pause/break key
		    case 20: key_string = "Caps"; break;
		    case vk_escape: key_string = "Esc"; break;
		    case vk_space: key_string = "Space"; break;
		    case vk_pageup: key_string = "Pg up"; break;
		    case vk_pagedown: key_string = "Pg down"; break;
		    case vk_end: key_string = "End"; break;
		    case vk_home: key_string = "Home"; break;
		    case vk_left: key_string = "Left"; break;
		    case vk_up: key_string = "Up"; break;
		    case vk_right: key_string = "Right"; break;
		    case vk_down: key_string = "Down"; break;
		    case vk_insert: key_string = "Ins"; break;
		    case vk_delete: key_string = "Del"; break;

		    //case 91: key_string = "Windows"; break;

		    case vk_numpad0: key_string = "Npad 0"; break;
		    case vk_numpad1: key_string = "Npad 1"; break;
		    case vk_numpad2: key_string = "Npad 2"; break;
		    case vk_numpad3: key_string = "Npad 3"; break;
		    case vk_numpad4: key_string = "Npad 4"; break;
		    case vk_numpad5: key_string = "Npad 5"; break;
		    case vk_numpad6: key_string = "Npad 6"; break;
		    case vk_numpad7: key_string = "Npad 7"; break;
		    case vk_numpad8: key_string = "Npad 8"; break;
		    case vk_numpad9: key_string = "Npad 9"; break;
		    case vk_multiply: key_string = "Npad *"; break;
		    case vk_add: key_string = "Npad +"; break;
		    case vk_subtract: key_string = "Npad -"; break;
		    case vk_decimal: key_string = "Npad ."; break;
		    case vk_divide: key_string = "Npad /"; break;

		    case vk_f1: key_string = "F1"; break;
		    case vk_f2: key_string = "F2"; break;
		    case vk_f3: key_string = "F3"; break;
		    case vk_f4: key_string = "F4"; break;
		    case vk_f5: key_string = "F5"; break;
		    case vk_f6: key_string = "F6"; break;
		    case vk_f7: key_string = "F7"; break;
		    case vk_f8: key_string = "F8"; break;
		    case vk_f9: key_string = "F9"; break;
		    case vk_f10: key_string = "F10"; break;
		    case vk_f11: key_string = "F11"; break;
		    case vk_f12: key_string = "F12"; break;

		    //case 144: key_string = "Nlock"; break;
		    //case 145: key_string = "Scroll lock"; break;

		    //case 160: key_string = "Shift (left)"; break;
		    //case 161: key_string = "Shift (right)"; break;
		    case vk_lcontrol: key_string = "L CTRL"; break;
		    case vk_rcontrol: key_string = "R CTRL"; break;
		    case vk_lalt: key_string = "L ALT"; break;
		    case vk_ralt: key_string = "R ALT"; break;

		    case 186: key_string = ";"; break;
		    case 187: key_string = "="; break;
		    case 188: key_string = ","; break;
		    case 189: key_string = "-"; break;
		    case 190: key_string = "."; break;
		    case 191: key_string = "/"; break;
		    case 192: key_string = "'"; break;

		    case 219: key_string = "["; break;
		    case 220: key_string = "\\"; break;
		    case 221: key_string = "]"; break;
		    case 222: key_string = "#"; break;
		    case 223: key_string = "`"; break;

		    default: key_string = "Invalid Key"; break;
		}
	}
	return key_string;
}




