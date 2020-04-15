//this is changes the zoom based on scrolling
zoom_level = clamp(zoom_level + (((mouse_wheel_down() - mouse_wheel_up())) * 0.1), 0.5, 2)

// get current size
var view_w = camera_get_view_width(view_camera[0])
var view_h = camera_get_view_height(view_camera[0])

// set the rate of interpolation
var rate = 0.2

// get new sizes by interpolating current and target zoomed size
new_w = lerp(view_w, zoom_level * default_zoom_width, rate)
new_h = lerp(view_h, zoom_level * default_zoom_height, rate)

// apply the new size
camera_set_view_size(view_camera[0], new_w, new_h)

vpos_x = camera_get_view_x(view_camera[0])
vpos_y = camera_get_view_y(view_camera[0])

var to_x = (keyboard_check(vk_right) - keyboard_check(vk_left)) * 15
var to_y = (keyboard_check(vk_down) - keyboard_check(vk_up)) * 15

// change coordinates of camera so zoom is centered
var new_x = lerp(vpos_x,vpos_x+to_x+(view_w - zoom_level * default_zoom_width)/2, rate)
var new_y = lerp(vpos_y,vpos_y+to_y+(view_h - zoom_level * default_zoom_height)/2, rate)

// mouse panning
if mouse_check_button_pressed(mb_middle) {
	cursor_x = mouse_x;
	cursor_y = mouse_y;
}

if mouse_check_button(mb_middle) {
	new_x += (cursor_x - mouse_x);
	new_y += (cursor_y - mouse_y);
}

camera_set_view_pos(view_camera[0], new_x, new_y)