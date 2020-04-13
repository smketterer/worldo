if not keyboard_check(vk_control) {
	for (var i=0; i<ds_list_size(selected); i++) {
		instance = ds_list_find_value(selected, i)
		instance.selected = false
	}
	ds_list_destroy(selected)
	selected = ds_list_create()
}

var instance = instance_position(mouse_x, mouse_y, all)
if instance and ds_list_find_index(selected, instance) < 0 {
	var i = ds_list_find_index(selected, instance)
	ds_list_add(selected, instance)
	instance.selected = true
	bbox = false // Whether to run the bounding box select on release or not.
} else {
	bbox = true
}

mouse_gui_x = window_mouse_get_x()
mouse_gui_y = window_mouse_get_y()

mouse_start_x = mouse_x
mouse_start_y = mouse_y