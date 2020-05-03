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
draw_text(5,28,"zoom: " + string(2 - Camera.zoom_level))
draw_text(5,40,"timescale: " + string(timescale))
draw_text(5,52,string(floor(hours % 24))+":"+string(round(minutes % 60)))
draw_text(5,64,string(day)+" day of "+string(season)+", Year "+string(year))

var pix = 0;
with (Person) {
	var offset = 104+(32*pix)
	draw_sprite(select2, image_index, 14, offset)
	draw_sprite(sprite_index, 0, 13, offset)
	draw_sprite(hands_sprite_index, 0, 13, offset)
	draw_text(28, offset - 18, nickname)
	draw_text(28, offset - 6, string(get_task_label(ds_priority_find_max(tasks))) + " | " + string(hp) + "/" + string(max_hp))
	pix++
}

var console_length = ds_list_size(console)
if Manager.debug and console_length > 0 {
	draw_set_colour(c_black)
	draw_set_alpha(.85)
	draw_rectangle(0,0,room_width,8+(12*(min(console_length,10)+1)),false)
	draw_set_alpha(1)
	draw_set_colour(c_white)
	var j = 0
	for (var i=max(0,console_length-10); i<=console_length-1; i++) {
		var message = ds_list_find_value(console,i)
		if string_pos("ERROR", message) { draw_set_colour(c_red) }
		if string_pos("#", message) == 1 { draw_set_colour(c_gray) }
		draw_text(5,4+(12*j),string(string(i) + ": " + string(message)))
		draw_set_colour(c_white)
		j++
	}
	draw_text(5,4+(12*(min(console_length,10))),"> " + keyboard_string)
}