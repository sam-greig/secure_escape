/// @description Draws Player Movement

//strip image is 9 frames long
var animation_length = 9;
var frame_size = 64;
var animation_speed = 12;

//updates the current frame by the direction the player is facing
switch(facing){
	case dir.left: y_frame = 9; break; //moving left change to moving left strip animation
	case dir.right: y_frame = 11; break; //right
	case dir.up: y_frame = 8; break;//up
	case dir.down: y_frame = 10; break;//down
	case -1: x_frame = 0; break; // player idle
}

//adjust offsets
var xx = x - x_offset;
var yy = y - y_offset;

//DRAW CHARACTER SHADOW
if(spr_shadow != -1){
	draw_sprite(spr_shadow, 0, x,y)
};

//DRAW CHARACTER BASE
if(spr_base != -1) draw_sprite_part(spr_base, 0, floor(x_frame)*frame_size, y_frame* frame_size, 64, 64, xx, yy); //increasing on mutiples of 64 for each frame/strip image

//DRAW CHARACTER FEET
if(spr_feet != -1) draw_sprite_part(spr_feet, 0, floor(x_frame)*frame_size, y_frame* frame_size, 64, 64, xx, yy); //increasing on mutiples of 64 for each frame/strip image

//DRAW CHARACTER LEGS
if(spr_legs != -1) draw_sprite_part(spr_legs, 0, floor(x_frame)*frame_size, y_frame* frame_size, 64, 64, xx, yy); //increasing on mutiples of 64 for each frame/strip image

//DRAW CHARACTER SHIRT
if(spr_torso != -1) draw_sprite_part(spr_torso, 0, floor(x_frame)*frame_size, y_frame* frame_size, 64, 64, xx, yy); //increasing on mutiples of 64 for each frame/strip image

//DRAW CHARACTER HAIR
if(spr_hair != -1) draw_sprite_part(spr_hair, 0, floor(x_frame)*frame_size, y_frame* frame_size, 64, 64, xx, yy); //increasing on mutiples of 64 for each frame/strip image

if(!can_move){
	x_frame = 0; //player idle when they can't move
}

//Increment frame for animation
if(x_frame + (animation_speed/60) < animation_length){
	x_frame += animation_speed/60; //frames per second
}
else{
	x_frame = 1;
}
