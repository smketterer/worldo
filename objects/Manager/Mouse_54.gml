var cellsize = self.cellsize
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)

with (Worker) {
	// Add all blocks and moveable characters' previous positions to grid
	mp_grid_add_instances(Manager.grid, Block, false)
	mp_grid_add_instances(Manager.grid, PassThrough, false)
	with (Worker) {
		mp_grid_add_cell(Manager.grid, floor(x/cellsize), floor(y/cellsize))
	}
	
	// Remove current entity instance from grid
	mp_grid_clear_cell(Manager.grid, floor(x/cellsize), floor(y/cellsize))
	
	// Set the goal positions
	var goal_cell_x = floor(mouse_x/cellsize)
	var goal_cell_y = floor(mouse_y/cellsize)
	
	// Try grabbing a basic path, if successful...
	var got_path = mp_grid_path(Manager.grid, path, x, y, goal_cell_x * cellsize, goal_cell_y * cellsize, true)
	
	if mp_grid_get_cell(Manager.grid, goal_cell_x, goal_cell_y) == 0 and got_path {
		// Mark the end position as blocked
		mp_grid_add_cell(Manager.grid, goal_cell_x, goal_cell_y)
		
		// Round the path values and start
		path = round_path(path)
		path_start(path, base_path_speed*Manager.timescale, 0, true)
	} else {
		// Did not successfully return a path, so move close. Loop through preferred postions and check for paths.
		var preferred = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
		
		for (var i=0; i<8; i++) {
			var rel_x = array_get(preferred[i], 0)
			var rel_y = array_get(preferred[i], 1)
			var new_goal_cell_x = goal_cell_x + rel_x
			var new_goal_cell_y = goal_cell_y + rel_y
			
			// If place is free, attempt to get a valid path.
			if mp_grid_get_cell(Manager.grid, new_goal_cell_x, new_goal_cell_y) == 0 {
				var got_path = mp_grid_path(Manager.grid, path, x, y, new_goal_cell_x*cellsize, new_goal_cell_y*cellsize, true)
				
				// Successfully got a path...
				if got_path {
					// Mark the end position as blocked
					mp_grid_add_cell(Manager.grid, new_goal_cell_x, new_goal_cell_y)
					
					// Round the path values
					path = round_path(path)
					path_start(path, base_path_speed*Manager.timescale, 0, true)
					
					// Break the for loop for moving close.
					break
				}
			}
		}
	}
}