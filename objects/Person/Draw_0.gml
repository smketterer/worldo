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

if ydir == 1 {
	draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
}
draw_sprite_ext(shadow0, image_index, x+8, y+8, image_xscale, image_yscale, image_angle, image_blend, abs(sqr(Manager.current_darkness)-1))
draw_sprite_ext(sprite_index, ydir, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
if ydir == 0 {
	draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
}