if not (claimed_by and claimed_by.hauling == self) {
	event_inherited()
	if stored {
		draw_sprite(stored0,image_index,x,y)
	}
}

if Camera.zoom_level < .75 and !stored {
	draw_set_halign(fa_center)
	draw_text(x+sprite_width/2,y+sprite_height,object_get_name(object_index))
	draw_set_halign(fa_left)
}