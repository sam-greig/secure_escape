/// @description Player Variables

can_move = true;
player_move_speed = 2;
facing = 0;
last_facing = pointer_null;
last_interactable_obj = noone;
last_room_depth_obj = noone;
player_interacting = false;

x_frame = 1;
y_frame = 8;

x_offset = sprite_get_xoffset(spr_player_mask);
y_offset = sprite_get_yoffset(spr_player_mask);

spr_base = spr_base_female_5;
spr_torso = spr_female_torso_sleeveless_red;
spr_legs = spr_female_legs_pants_teal;
spr_hair = spr_female_hair_ponytail_raven;
spr_feet = spr_female_feet_boots_black;
spr_shadow = spr_character_shadow;