if not (claimed_by and claimed_by.hauling == self) {
	event_inherited()
	if stored {
		draw_sprite(stored0,image_index,x,y)
	}
}