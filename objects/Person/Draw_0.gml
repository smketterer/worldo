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

var mouse_dir = point_direction(mouse_x,mouse_y,x,y)
var offset = mouse_check_button_pressed(mb_left) * -8
current_handsoffset = lerp(current_handsoffset, offset, .25)

var gun_xscale = -1
var gun_yscale = 1
if mouse_dir > 90 and mouse_dir < 270 {
	gun_xscale = 1
	mouse_dir-=180
}
if current_xscale < 0 {
	mouse_dir+=180
	gun_yscale = -1
}
var kickback_x = lengthdir_x(current_handsoffset*gun_xscale*gun_yscale,mouse_dir)
var kickback_y = lengthdir_y(current_handsoffset*gun_xscale*gun_yscale,mouse_dir)

if ydir == 1 {
	if hauling == noone {
		if hands_sprite_index = handsShotgun {
			draw_sprite_ext(hands_sprite_index, image_index, x+8-(gun_xscale*2)+kickback_x, draw_y+8+kickback_y, current_xscale*gun_xscale, image_yscale*gun_yscale, mouse_dir, image_blend, image_alpha)
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
		if hands_sprite_index = handsShotgun {
			draw_sprite_ext(hands_sprite_index, image_index, x+8-(gun_xscale*2)+kickback_x, draw_y+8+kickback_y, current_xscale*gun_xscale, image_yscale*gun_yscale, mouse_dir, image_blend, image_alpha)
		} else {
			draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
		}
	} else {
		draw_sprite_ext(hauling.sprite_index, image_index, x, draw_y-1, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	}
}