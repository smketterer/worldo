str_selected = ""
size = ds_list_size(selected)
for (var i=0; i<size; i++) {
	if (variable_instance_exists(ds_list_find_value(selected, i), "nickname")) {
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

#region tabs
if active_panel != "none" {
	var top = window_get_height() - tab_height
	var bottom = window_get_height() - 16
	draw_set_colour(make_color_rgb(7,7,8))
	draw_rectangle(0,top, tab_width, bottom, false)
	draw_set_colour(c_black)
	draw_rectangle(0,top, tab_width, bottom, true)
	draw_set_colour(make_color_rgb(20,20,20))
	draw_rectangle(1,top+1, tab_width-1, bottom, true)
	draw_set_colour(c_gray)
	draw_text(8,top+4,active_panel)
	draw_set_colour(c_white)
}
switch active_panel {
	case "Inspecting":
		if inspecting.object_index == Person {
			draw_text(8,top+16,inspecting.name)
			draw_text(8,top+28,string(inspecting.age) + " year old " + inspecting.sex + " colonist")
			draw_set_colour(c_black)
			draw_line(0,top+47,tab_width-1,top+47)
			draw_set_colour(make_color_rgb(20,20,20))
			draw_line(1,top+48,tab_width-1,top+48)
			draw_set_colour(c_white)
		}
		break
	case "Build objects":
		
	default:
		break
}
#endregion

#region person list
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
#endregion

#region console
var console_length = ds_list_size(console)
if Manager.debug and console_length > 0 {
	draw_set_colour(c_black)
	draw_set_alpha(.85)
	draw_rectangle(0,0,room_width,8+(12*(min(console_length,10)+1)),false)
	draw_set_alpha(1)
	draw_set_colour(c_ltgray)
	var j = 0
	for (var i=max(0,console_length-10); i<=console_length-1; i++) {
		var message = ds_list_find_value(console,i)
		if string_pos("\t", message) { draw_set_colour(c_red) }
		if string_pos("#", string(message)) == 1 or string_pos("undefined", string(message)) { draw_set_colour(c_gray) }
		draw_text(4,4+(12*j),string(string(message)))
		draw_set_colour(c_ltgray)
		j++
	}
	draw_set_colour(c_white)
	
	var i, h, ptext;
	ptext = string_replace_all(text, "#", "�")
	draw_text(4,4+(12*(min(console_length,10))),"$ ")
	draw_text(4+string_width("$ "),4+(12*(min(console_length,10))), string_hash_to_newline(ptext))
	i = string_width(string_hash_to_newline(string_copy(ptext, 1, caret)))
	h = string_height(string_hash_to_newline("\\\\"))
	draw_line(4+i+string_width("$ "),6+(12*(min(console_length,10))),5+i+string_width("$ "),1+(12*(min(console_length,10)))+h)
}
#endregion