str_selected = ""
size = ds_list_size(selected)
for (var i=0; i<size; i++) {
	if (variable_instance_exists(ds_list_find_value(selected, i), "nickname")) {
		str_selected += string(ds_list_find_value(selected, i).nickname)
		str_selected += ","
	} else if instance_exists(ds_list_find_value(selected, i)) {
		str_selected += string(ds_list_find_value(selected, i))
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
	var bottom = window_get_height() - 15
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
		if instance_exists(inspecting) {
			if inspecting.object_index == Person or object_is_ancestor(inspecting.object_index, Person) {
				// Person
				draw_text(8,top+17,inspecting.name)
				draw_health_bar(top)
				
				var ff = inspecting.faction
				if string_length(ff) > 0 and ff == "player" {
					draw_set_colour(merge_colour(c_blue,c_aqua,.5))
				} else {
					draw_set_colour(merge_colour(c_red,c_gray,.5))
				}
				draw_text(8+68,top+31,capitalize(string(ff)))
				draw_line(8+67,top+44,8+65+string_width(ff),top+44)
				draw_set_colour(c_white)
				draw_text(8,top+47,string(inspecting.age) + " year old " + inspecting.sex)
				
				
				var sectionoffset = top+82
				draw_set_colour(c_black)
				draw_line(0,sectionoffset,tab_width-1,sectionoffset)
				draw_set_colour(make_color_rgb(20,20,20))
				draw_line(1,sectionoffset+1,tab_width-1,sectionoffset+1)
				draw_set_colour(c_white)
				
				sectionoffset += 4
				draw_set_colour(c_gray)
				draw_text(8,sectionoffset,"Skills")
				draw_set_colour(c_white)
				
				sectionoffset += 13
				draw_sprite(icons0,0,8,sectionoffset+2)
				draw_text(8+13,sectionoffset,capitalize(string(inspecting.chopping_skill)))
				draw_sprite(icons0,1,8+round(tab_width/8),sectionoffset+2)
				draw_text(8+13+round(tab_width/8),sectionoffset,capitalize(string(inspecting.cutting_skill)))
				draw_sprite(icons0,2,8+round(tab_width*2/8),sectionoffset+2)
				draw_text(8+13+round(tab_width*2/8),sectionoffset,capitalize(string(inspecting.building_skill)))
				draw_sprite(icons0,3,8+round(tab_width*3/8),sectionoffset+2)
				draw_text(8+13+round(tab_width*3/8),sectionoffset,capitalize(string(inspecting.hauling_skill)))
				draw_sprite(icons0,4,8+round(tab_width*4/8),sectionoffset+2)
				draw_text(8+13+round(tab_width*4/8),sectionoffset,capitalize(string(inspecting.shooting_skill)))
				draw_sprite(icons0,5,8+round(tab_width*5/8),sectionoffset+2)
				draw_text(8+13+round(tab_width*5/8),sectionoffset,capitalize(string(inspecting.move_speed)))
				
				sectionoffset += 18
				draw_set_colour(c_black)
				draw_line(0,sectionoffset,tab_width-1,sectionoffset)
				draw_set_colour(make_color_rgb(20,20,20))
				draw_line(1,sectionoffset+1,tab_width-1,sectionoffset+1)
				draw_set_colour(c_white)
				

			} else if inspecting.object_index == Blueprint {
				// Blueprint
				var obj_name = get_object_name(inspecting.object_index)
				if !string_length(obj_name) {
					// Fall back to object name
					obj_name = object_get_name(inspecting.object_index)
				} else {
					obj_name = capitalize(obj_name)
				}
				draw_text(8,top+17,obj_name)
				draw_health_bar(top)
				
				draw_text(8,top+47,"Work remaining: " + string(round(inspecting.work)))
				draw_set_colour(c_gray)
				draw_text_ext(8,top+66,inspecting.description,12,tab_width-22)
				draw_set_colour(c_white)
			} else {
				// Default
				var obj_name = get_object_name(inspecting.object_index)
				if !string_length(obj_name) {
					// Fall back to object name
					obj_name = object_get_name(inspecting.object_index)
				} else {
					obj_name = capitalize(obj_name)
				}
				draw_text(8,top+17,obj_name)
				draw_health_bar(top)
				
				draw_set_colour(c_gray)
				draw_text_ext(8,top+47,inspecting.description,12,tab_width-22)
				draw_set_colour(c_white)
			}
		}
		break
	case "Build objects":
		// Buttons added via TabBuild onclick
		break
	default:
		break
}
#endregion

#region person list
var pix = 0;
with (Person) {
	if faction != "player" { break }
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