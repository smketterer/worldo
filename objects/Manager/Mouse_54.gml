var cellsize = self.cellsize
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)

for (var i=0; i<ds_list_size(selected); i++) {
	var instance = ds_list_find_value(selected, i)
	
	// Not a worker, can't be moved
	if not object_is_ancestor(instance.object_index, Worker) {
		continue
	}
	
	// Add all blocks to grid
	mp_grid_add_instances(Manager.grid, Block, false)
	mp_grid_add_instances(Manager.grid, PassThrough, false)
	
	// Add all entities to grid
	with (Entity) {
		mp_grid_add_cell(Manager.grid, floor(x/cellsize), floor(y/cellsize))
	}
	
	// Remove current entity instance from grid
	mp_grid_clear_cell(Manager.grid, floor(instance.x/cellsize), floor(instance.y/cellsize))
	
	// Set the goal positions
	var goal_cell_x = floor(mouse_x/cellsize)
	var goal_cell_y = floor(mouse_y/cellsize)
	var goal_x = goal_cell_x * cellsize
	var goal_y = goal_cell_y * cellsize
	
	// Try grabbing a basic path
	var got_path = mp_grid_path(Manager.grid, instance.path, instance.x, instance.y, goal_x, goal_y, true)
	
	// If successfully returned a path...
	if mp_grid_get_cell(Manager.grid, goal_cell_x, goal_cell_y) == 0 and got_path {
		// Mark the end position as blocked
		mp_grid_add_cell(Manager.grid, goal_cell_x, goal_cell_y)
		
		// Round the path values
		with (instance) {
			path = round_path(path)
			path_start(path, instance.base_path_speed * Manager.timescale, 0, true)
		}
	} else {
		// Did not successfully return a path, so move close
		with (instance) {
			// Loop through preferred postions and check for paths
			var preferred = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
			for (var ii=0; ii<8; ii++) {
				var placex = array_get(preferred[ii],0)
				var placey = array_get(preferred[ii],1)
				var gx = goal_cell_x + placex
				var gy = goal_cell_y + placey
				
				// If place is free...
				if mp_grid_get_cell(Manager.grid, gx, gy) == 0 {
					var got_path = mp_grid_path(Manager.grid, path, x, y, gx * cellsize, gy * cellsize, true)
					
					// If path is valid...
					if got_path {
						// Mark the end position as blocked
						mp_grid_add_cell(Manager.grid, gx, gy)
						
						// Round the path values
						path = round_path(path)
						path_start(path, instance.base_path_speed * Manager.timescale, 0, true)
						break
					}
				}
			}
		}
	}
}