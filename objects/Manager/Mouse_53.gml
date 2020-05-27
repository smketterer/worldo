// cancel if overtop GUI
var mousex = device_mouse_x_to_gui(0) // GUI position of mouse's x coordinate
var mousey = device_mouse_y_to_gui(0) // GUI position of mouse's y coordinate
var top = 0
if active_panel == "none" {
	top = 16
} else {
	top = tab_height
}
if (point_in_rectangle(mousex, mousey, 0, window_get_height()-top, tab_width, window_get_height())) {
	bbox = false
	exit
}

if cursor_mode == "select" {
	reset_active_panel()
	
	// Select multiple
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

	// Stack selection
	var instances = ds_list_create()
	var instance = instance_position(mouse_x, mouse_y, Entity)
	instance_position_list(mouse_x,mouse_y,Entity,instances,false)
	for (var j=0; j<ds_list_size(instances); j++) {
		var item = ds_list_find_value(instances,j)
		if inspecting == item and j < ds_list_size(instances)-1 {
			instance = ds_list_find_value(instances,j+1)
		}
	}
	
	// Inspect item
	if instance and object_is_ancestor(instance.object_index, Entity) and ds_list_find_index(selected, instance) < 0 {
		var i = ds_list_find_index(selected, instance)
		ds_list_add(selected, instance)
		instance.selected = true
		inspecting = instance
		set_active_panel("Inspecting")
		bbox = false
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
	if active_blueprint {
		var mouse_xx = floor(mouse_x/cellsize)*cellsize
		var mouse_yy = floor(mouse_y/cellsize)*cellsize
		
		var meeting_non_floor_instance = false
		var instances = ds_list_create()
		instance_position_list(mouse_xx,mouse_yy,Entity,instances,false)
		for (var j=0; j<ds_list_size(instances); j++) {
			var item = ds_list_find_value(instances,j)
			if layer_get_name(item.layer) != "Floors" {
				meeting_non_floor_instance = true
			}
		}
	
		if !instance_position(mouse_xx,mouse_yy,Zone) and not meeting_non_floor_instance {
			// Check if it's a floor, in which case put blueprint on floor layer
			if active_blueprint == Floor {
				var blueprint = instance_create_layer(mouse_xx,mouse_yy,"Floors",Blueprint)
			} else {
				var blueprint = instance_create_layer(mouse_xx,mouse_yy,"Instances",Blueprint)
			}
			blueprint.object = active_blueprint
			blueprint.requirement = get_object_requirement(active_blueprint)
			blueprint.work = get_object_work(active_blueprint)
			blueprint.description = "A " + string(get_object_name(active_blueprint)) + " blueprint."
		} else {
			log("can't build here")
		}
	} else {
		cursor_mode = "select"
	}
} else if cursor_mode == "zone" {
	var mouse_xx = floor(mouse_x/cellsize)*cellsize
	var mouse_yy = floor(mouse_y/cellsize)*cellsize
	if !instance_position(mouse_xx,mouse_yy,all) {
		instance_create_layer(mouse_xx,mouse_yy,"Floors",Zone)
	}
}