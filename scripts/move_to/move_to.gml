var to_x = argument0
var to_y = argument1
var grid = Manager.grid
var cs = Manager.cellsize

// Add all blocks and moveable characters' previous positions to grid
mp_grid_add_instances(grid, Block, false)
mp_grid_add_instances(grid, PassThrough, false)
var prev = ds_list_create()
with (Worker) {
	mp_grid_add_cell(grid, floor(x/cs), floor(y/cs))
	ds_list_add(prev, [floor(x/cs),floor(y/cs)])
}
	
// Remove current entity instance from grid
mp_grid_clear_cell(grid, floor(x/cs), floor(y/cs))
	
// Set the goal positions
var goal_cell_x = floor(to_x/cs)
var goal_cell_y = floor(to_y/cs)
	
// Try grabbing a basic path, if successful...
var got_path = mp_grid_path(grid, path, x, y, goal_cell_x*cs, goal_cell_y*cs, true)
if mp_grid_get_cell(grid, goal_cell_x, goal_cell_y) == 0 and got_path {
	// Mark the end position as blocked
	mp_grid_add_cell(grid, goal_cell_x, goal_cell_y)
		
	// Round the path values and start
	path = round_path(path)
	path_start(path, base_path_speed*Manager.timescale, 0, true)
	
	// Clean up cells
	for (var j=0; j<ds_list_size(prev); j++) {
		var coords = ds_list_find_value(prev,j)
		mp_grid_clear_cell(grid, coords[0], coords[1])
	}
} else {
	// Did not successfully return a path, so move close. Loop through preferred postions and check for paths
	var preferred = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
	for (var i=0; i<8; i++) {
		var rel_x = array_get(preferred[i], 0)
		var rel_y = array_get(preferred[i], 1)
		var new_goal_cell_x = goal_cell_x+rel_x
		var new_goal_cell_y = goal_cell_y+rel_y
			
		// If place is free, attempt to get a valid path
		if mp_grid_get_cell(grid, new_goal_cell_x, new_goal_cell_y) == 0 {
			var got_path = mp_grid_path(grid, path, x, y, new_goal_cell_x*cs, new_goal_cell_y*cs, true)
				
			// Successfully got a path...
			if got_path {
				// Mark the end position as blocked
				mp_grid_add_cell(grid, new_goal_cell_x, new_goal_cell_y)
					
				// Round the path values and start
				path = round_path(path)
				path_start(path, base_path_speed*Manager.timescale, 0, true)
				
				// Clean up previous positions
				for (var j=0; j<ds_list_size(prev); j++) {
					var coords = ds_list_find_value(prev,j)
					mp_grid_clear_cell(grid, coords[0], coords[1])
				}
					
				// Break the for loop for moving close
				break
			}
		}
	}
}