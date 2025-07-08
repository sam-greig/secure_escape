/// @description Insert description here
// You can write your code in this editor

//interaction overlay variables
draw_overlay = false;
overlay_target = -1;
overlay_sub_img = 0;
overlay_scale_x = 0;
overlay_scale_y = 0;
offset_width = 1;
offset_height = 1;

//game room timer variables
timer_on = false;
starting_mins = 60;
starting_seconds = 60*0;
mins = starting_mins;
seconds = starting_seconds;

//subtitle variables
dialog = [];
subtitle_index = 0;
dialog_index = 0;
text_index = 0;                    
typing_speed = 40; 
text="";

//boolean flags
show_subtitles = false;
keyboard_reset = false;