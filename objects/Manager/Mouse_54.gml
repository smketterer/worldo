// Set relevant variables
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)

with (Worker) {
	if !selected or !(ds_priority_find_max(tasks) == "WAR") { continue }
	move_to(mouse_x, mouse_y)
}