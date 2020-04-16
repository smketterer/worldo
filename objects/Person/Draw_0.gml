event_inherited()

if selected {
	draw_sprite_ext(select1, image_index, x+8, y+8, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}

if moving {
	offset = sin(move_length * Manager.timescale / 2)
	amount = 1.5
	draw_y = (y - (offset * amount) - 1.5)
} else {
	draw_y = lerp(draw_y, y, .25 * Manager.timescale)
}

current_xscale = lerp(current_xscale, dir, .15)

draw_sprite(shadow, image_index, x+8, y+8)
draw_sprite_ext(sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
