var mousex = device_mouse_x_to_gui(0) // GUI position of mouse's x coordinate
var mousey = device_mouse_y_to_gui(0) // GUI position of mouse's y coordinate
if (point_in_rectangle(mousex, mousey, 2,(window_get_height()-Manager.tab_height)+(22*i)+22,Manager.tab_width-2,(window_get_height()-Manager.tab_height)+(22*i)+43)) {
	hovered = true
} else {
	hovered = false
}