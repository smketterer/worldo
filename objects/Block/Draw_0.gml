draw_self()

if selected {
	offset_x = x-sprite_xoffset-1
	offset_y = y-sprite_yoffset-1
	box_width = sprite_width
	box_height = sprite_height
	draw_set_alpha(.75)
	draw_rectangle(offset_x, offset_y, offset_x+box_width, offset_y+box_height, true)
	draw_set_alpha(1)
}