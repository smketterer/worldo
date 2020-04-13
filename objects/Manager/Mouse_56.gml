if bbox == true {
	for (var i=0; i<ds_list_size(selected); i++) {
		instance = ds_list_find_value(selected, i)
		instance.selected = false
	}
	ds_list_destroy(selected)
	selected = ds_list_create()

	var instances = collision_rectangle_list(mouse_start_x, mouse_start_y, mouse_x, mouse_y, Entity, false, false, selected, false)
	if instances > 0 {
		for (var i=0; i<ds_list_size(selected); i++) {
			var instance = ds_list_find_value(selected, i)
			instance.selected = true
		}
	}
}