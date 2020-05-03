var mousex = device_mouse_x_to_gui(0) // GUI position of mouse's x coordinate
var mousey = device_mouse_y_to_gui(0) // GUI position of mouse's y coordinate
if (point_in_rectangle(mousex, mousey, x, y, x + sprite_width, y + sprite_height)) {
	hovered = true
} else {
	hovered = false
}