str_selected = ""
size = ds_list_size(selected)
for (var i=0; i<size; i++) {
	if i > 0 {
		str_selected += ","
	}
	str_selected += string(ds_list_find_value(selected, i).id)
}
draw_text(5,5,"[" + str_selected + "]")

if mouse_check_button(mb_left) and bbox {
	draw_rectangle(mouse_gui_x, mouse_gui_y, window_mouse_get_x(), window_mouse_get_y(), true)
}
draw_text(5,16,"[" + string(mouse_x) + ", " + string(mouse_y) + "]")

for (var i=0; i<size; i++) {
	if i > 0 {
		str_selected += ","
	}
	str_selected += string(ds_list_find_value(selected, i).id)
}