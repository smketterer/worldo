// Set relevant variables
if cursor_mode == "select" {
	grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)

	with (Worker) {
		if !selected or !(ds_priority_find_max(tasks) == "DRAFT") { continue }
		move_to(mouse_x, mouse_y)
	}
} else {
	cursor_mode = "select"
}