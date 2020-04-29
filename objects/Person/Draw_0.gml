event_inherited()

if moving {
	offset = sin(move_length * Manager.timescale / 2)
	amount = 1.5
	draw_y = (y - (offset * amount) - 1.5)
} else {
	draw_y = lerp(draw_y, y, .25 * Manager.timescale)
}

draw_set_alpha(.015)
for (var i=-4; i<4; i++) {
	for (var j=-4; j<4; j++) {
		draw_path(path,path_get_point_x(path,0)+8+(i/2),path_get_point_y(path,0)+8+(j/2),false)
	}
}
draw_set_alpha(1)

current_xscale = lerp(current_xscale, dir, .15)

var visual_aim_dir = aim_dir
var offset = firing * -8
current_handsoffset = lerp(current_handsoffset, offset, .25)

var gun_xscale = 1
var gun_yscale = 1
if visual_aim_dir >= 90 and visual_aim_dir <= 270 {
	gun_xscale = -1
	visual_aim_dir+=180
}
if current_xscale < 0 {
	visual_aim_dir-=180
	gun_yscale = -1
}
var kickback_x = lengthdir_x(current_handsoffset*gun_xscale*gun_yscale,visual_aim_dir)
var kickback_y = lengthdir_y(current_handsoffset*gun_xscale*gun_yscale,visual_aim_dir)

if ydir == 1 {
	if hauling == noone {
		// check if has weapon
		if ds_list_find_index(equip,Shotgun) >= 0 {
			draw_sprite_ext(handsShotgun, image_index, x+8+kickback_x, draw_y+5+kickback_y, current_xscale*gun_xscale, image_yscale*gun_yscale, visual_aim_dir, image_blend, image_alpha)
			barrel_x = x+8-(gun_xscale*2)
			barrel_y = draw_y+3
		} else {
			draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
		}
	} else {
		draw_sprite_ext(hauling.sprite_index, image_index, x, draw_y-1, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	}
}
draw_sprite_ext(shadow0, image_index, x+8, y+8, image_xscale, image_yscale, image_angle, image_blend, abs(sqr(Manager.current_darkness)-1))
draw_sprite_ext(sprite_index, ydir, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
if ydir == 0 {
	if hauling == noone {
		// check if has weapon
		if ds_list_find_index(equip,Shotgun) >= 0 {
			draw_sprite_ext(handsShotgun, image_index, x+8-(gun_xscale)+kickback_x, draw_y+8+kickback_y, current_xscale*gun_xscale, image_yscale*gun_yscale, visual_aim_dir, image_blend, image_alpha)
			barrel_x = x+8+(gun_xscale*2)
			barrel_y = draw_y+6
		} else {
			draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
		}
	} else {
		draw_sprite_ext(hauling.sprite_index, image_index, x, draw_y-1, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	}
}

barrel_x += lengthdir_x(13,aim_dir)
barrel_y += lengthdir_y(13,aim_dir)

// debug barrel pos
// draw_set_color(c_red)
// draw_point(barrel_x,barrel_y)
// draw_set_color(c_white)