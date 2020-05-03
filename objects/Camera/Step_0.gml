//this is changes the zoom based on scrolling
zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.5, 2)
var display_zoom = zoom_level

if zoom_level > 1 {
	gpu_set_texfilter(true)
} else {
	gpu_set_texfilter(false)
}

if zoom_level <= 1 {
	display_zoom = round(zoom_level * 2) / 2
}

// get current size
var view_w = camera_get_view_width(view_camera[0])
var view_h = camera_get_view_height(view_camera[0])

// set the rate of interpolation
var rate = 0.2

// get new sizes by interpolating current and target zoomed size
new_w = lerp(view_w, display_zoom * default_zoom_width, rate)
new_h = lerp(view_h, display_zoom * default_zoom_height, rate)

// apply the new size
camera_set_view_size(view_camera[0], new_w, new_h)

vpos_x = camera_get_view_x(view_camera[0])
vpos_y = camera_get_view_y(view_camera[0])

var cam_speed = 25
if (keyboard_check(vk_shift)) {
	cam_speed = 50
}

var to_x = 0
var to_y = 0
if !Manager.debug {
	to_x = ((keyboard_check(ord("D")) - keyboard_check(ord("A"))) * cam_speed * (display_zoom))
	to_y = ((keyboard_check(ord("S")) - keyboard_check(ord("W"))) * cam_speed * (display_zoom))
}

var new_x = lerp(vpos_x,vpos_x+to_x+(view_w - display_zoom * default_zoom_width)/2, rate)
var new_y = lerp(vpos_y,vpos_y+to_y+(view_h - display_zoom * default_zoom_height)/2, rate)

if mouse_check_button_pressed(mb_middle) {
	cursor_x = mouse_x;
	cursor_y = mouse_y;
}

if mouse_check_button(mb_middle) {
	new_x += (cursor_x - mouse_x);
	new_y += (cursor_y - mouse_y);
}

camera_set_view_pos(view_camera[0], new_x, new_y)

if keyboard_check_pressed(vk_home) {
	rounded_zoom = round(zoom_level / .5) * .5
	zoom_level = rounded_zoom - .5	
}

if keyboard_check_pressed(vk_end) {
	rounded_zoom = round(zoom_level / .5) * .5
	zoom_level = rounded_zoom + .5
}