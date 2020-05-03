if cursor_mode == "select" {
	if not keyboard_check(vk_control) {
		for (var i=0; i<ds_list_size(selected); i++) {
			if instance_exists(ds_list_find_value(selected, i)) {
				instance = ds_list_find_value(selected, i)
				instance.selected = false
			}
		}
		ds_list_destroy(selected)
		selected = ds_list_create()
	}

	var instance = instance_position(mouse_x, mouse_y, all)
	if instance and ds_list_find_index(selected, instance) < 0 and object_is_ancestor(instance.object_index, Entity) {
		var i = ds_list_find_index(selected, instance)
		ds_list_add(selected, instance)
		instance.selected = true
		bbox = false // Whether to run the bounding box select on release or not.
	} else {
		bbox = true
	}
	
	var button_selected = false
	with Button {
		if hovered == true {
			button_selected = true
		}
	}
	if button_selected {
		bbox = false
	}

	mouse_gui_x = window_mouse_get_x()
	mouse_gui_y = window_mouse_get_y()

	mouse_start_x = mouse_x
	mouse_start_y = mouse_y
} else if cursor_mode == "build" {
	var mouse_xx = floor(mouse_x/cellsize)*cellsize
	var mouse_yy = floor(mouse_y/cellsize)*cellsize
	
	if !instance_position(mouse_xx,mouse_yy,Zone) {
		var blueprint = instance_create_layer(mouse_xx,mouse_yy,"Instances",Blueprint)
	} else {
		log("can't build on a zone")
	}
}