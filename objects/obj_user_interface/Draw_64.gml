/// @description Draws UI

if(draw_overlay){
	//grey out background
	draw_set_color(c_black);
	draw_set_alpha(0.5);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);	
	//reset to default
	draw_set_color(c_white);
	draw_set_alpha(1);
}

if(room == rm_escape_room){
	//displaying timer
	var box_x = display_get_gui_width() / 2 - obj_player.sprite_width*2.5;
	var box_y = 0;
	var box_scale = 5;
	//draws timer box
	draw_sprite_ext(
	    spr_room_timer,  // Sprite to display
	    0,               // Sub-image
	    box_x,           // X position
	    box_y,           // Y position
	    box_scale,       // X scale
	    box_scale,       // Y scale
	    0,               // Rotation
	    c_white,         // Blend color
	    1                // Alpha
	);
	draw_set_font(fnt_rockwell_32px);
	draw_set_color(c_white);

	var display_text = "";
	//adds extra 0 if only one digit
	if (string_length(string(mins)) == 1) {
	    display_text = "0" + string(mins);
	} else {
	    display_text = string(mins);
	}

	if (string_length(string(floor(seconds / 60))) == 1) {
	    display_text = display_text + " : 0" + string(floor(seconds / 60));
	} else {
	    display_text = display_text + " : " + string(floor(seconds / 60));
	}

	//calculate text width and position
	var text_width = string_width(display_text); // Get the width of the text
	var text_x = box_x + (sprite_get_width(spr_room_timer) * box_scale / 2) - (text_width / 2); // Center the text
	var text_y = box_y + (sprite_get_height(spr_room_timer) - box_scale / 2) + string_height(display_text) / box_scale; // Vertically center

	draw_text(text_x, text_y, display_text);
}

//drawing overlay
if (draw_overlay){
	draw_sprite_ext(
	overlay_target,
	overlay_sub_img,
	display_get_gui_width() / 2 - sprite_get_width(overlay_target) / offset_width,
    display_get_gui_height() / 2 - sprite_get_height(overlay_target) / offset_height,
	overlay_scale_x,
	overlay_scale_y,
	0,
	c_white,
	1
	);
}

//displaying subtitles
if(show_subtitles){	
	//size variables
	var rect_width = 600;
	var rect_height = 100;
	var border_thickness = 4;
	var y_offset = 150; 	
	
	//draws subtitle box border
	draw_roundrect_color(
	    display_get_gui_width() / 2 + obj_player.sprite_width - rect_width,
		display_get_gui_height() - rect_height - y_offset,
		display_get_gui_width() / 2 - obj_player.sprite_width + rect_width, 
		display_get_gui_height() + rect_height - y_offset,
		c_black, 
		c_black,
	    false
	);
	
	var x1 = display_get_gui_width() / 2 + obj_player.sprite_width - rect_width + border_thickness;
	var y1 = display_get_gui_height() - rect_height + border_thickness - y_offset;
	var x2 = display_get_gui_width() / 2 - obj_player.sprite_width + rect_width - border_thickness;
	var y2 = display_get_gui_height() + rect_height - border_thickness - y_offset;
	
	//draws subtitle inner box
	draw_roundrect_color(
	    x1, 
		y1,		
		x2, 
		y2,
		c_white, 
		c_white,
	    false 
	);

	//draws subtitle text
	draw_set_font(fnt_rockwell_24px);
	draw_set_color(c_black);
	var text_offset = 32;
	var line_seperation = 40;
	draw_text_ext(x1+text_offset,y1+text_offset, string_copy(text, 0, ceil(text_index)), line_seperation, rect_width * 2 - text_offset * 9);
}