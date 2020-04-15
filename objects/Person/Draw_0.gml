event_inherited()

if moving {
	offset = sin(move_length / 2)
	amount = 1.5
	draw_y = y - (offset * amount) - 1.5
} else {
	draw_y = lerp(draw_y, y, .25)
}

current_xscale = lerp(current_xscale, dir, .15)

draw_sprite(shadow, image_index, x+8, y+8)
draw_sprite_ext(sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)
draw_sprite_ext(hands_sprite_index, image_index, x+8, draw_y+8, current_xscale, image_yscale, image_angle, image_blend, image_alpha)

if selected {
	offset_x = x-sprite_xoffset+4
	offset_y = y-sprite_yoffset+4
	box_width = sprite_width+5
	box_height = sprite_height+4
	draw_set_alpha(.75)
	draw_rectangle(offset_x, offset_y, offset_x+box_width, offset_y+box_height, true)
	draw_set_alpha(1)
}