draw_self()

if selected {
	draw_sprite_part(select0, image_index,0,0,6,6,x-2,y-2)
	draw_sprite_part(select0, image_index,14,0,6,6,x+sprite_width-4,y-2)
	draw_sprite_part(select0, image_index,14,14,6,6,x+sprite_width-4,y+sprite_height-4)
	draw_sprite_part(select0, image_index,0,14,6,6,x-2,y+sprite_height-4)
}