str_selected = ""
size = ds_list_size(selected)
for (var i=0; i<size; i++) {
	if (variable_instance_exists(ds_list_find_value(selected, i), "name")) {
		str_selected += string(ds_list_find_value(selected, i).nickname)
		str_selected += ","
	} else if instance_exists(ds_list_find_value(selected, i)) {
		str_selected += string(object_get_name(ds_list_find_value(selected, i).object_index))
		str_selected += ","
	} else {
		continue
	}
}
draw_text(5,4,"[" + str_selected + "]")

if mouse_check_button(mb_left) and bbox {
	draw_rectangle(mouse_gui_x, mouse_gui_y, window_mouse_get_x(), window_mouse_get_y(), true)
}
draw_text(5,16,"[" + string(mouse_x) + ", " + string(mouse_y) + "]")
draw_text(5,28,"zoom: " + string((1 - Camera.zoom_level)*10))
draw_text(5,40,"timescale: " + string(timescale))
draw_text(5,52,string(floor(hours % 24))+":"+string(round(minutes % 60)))
draw_text(5,64,string(day)+" day of "+string(season)+", Year "+string(year))

var pix = 0;
with (Person) {
	var offset = 104+(32*pix)
	draw_sprite(select2, image_index, 14, offset)
	draw_sprite(sprite_index, 0, 13, offset)
	draw_sprite(hands_sprite_index, 0, 13, offset)
	draw_text(28, offset - 18, name)
	draw_text(28, offset - 6, string(get_task_label(ds_priority_find_max(tasks))) + " | " + string(hp) + "/" + string(max_hp))
	pix++
}