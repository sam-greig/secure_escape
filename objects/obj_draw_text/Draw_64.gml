/// @description Insert description here
// You can write your code in this editor
depth = -1; //ensure it is drawn ontop of everything

if (drawing) {
    draw_set_font(text_font);
    draw_set_color(text_colour);
	draw_set_alpha(text_alpha);
	var font_info = font_get_info(text_font);
    //starting position
    var current_x = pos_x;
    var current_y = pos_y;
    //loops through each letter in array
    for (var i = 0; i < array_length(input_text); i++) {
	    var letter = string(input_text[i]); // Get the character from the array
		if (calculate_string_width) current_x -= string_width(letter)/2;
	    draw_text(current_x, current_y, letter);
		if (calculate_string_width) current_x += string_width(letter)/2;
    
	    //add offsets
	    current_x += offset_x;
	    current_y += offset_y;
	}
}
else{
	//reset variables
	draw_set_font(-1);
	draw_set_color(c_white);
	input_text = [];
	pos_x = 0;
	pos_y = 0;
	offset_x = 0;
	offset_y = 0;
}




