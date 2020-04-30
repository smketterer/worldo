var to_x = argument0
var to_y = argument1
var grid = Manager.grid
var cs = Manager.cellsize

// Add all blocks and moveable characters' previous positions to grid
mp_grid_add_instances(grid, Block, false)
mp_grid_add_instances(grid, PassThrough, false)

// Clear storable zones
with (Zone) {
	mp_grid_clear_cell(grid, floor(x/cs), floor(y/cs))
}

var prev = ds_list_create()
var current_instance = self

path = path_add()
path_set_closed(path, false)

with (Worker) {
	mp_grid_add_cell(grid, floor(x/cs), floor(y/cs))
	ds_list_add(prev, [floor(x/cs),floor(y/cs)])
	
	// Add endpoints of any currently moving instance
	if path and path_position < 1 and current_instance != self {
		mp_grid_add_cell(Manager.grid, path_get_point_x(path, path_get_number(path)-1)/cs, path_get_point_y(path, path_get_number(path)-1)/cs)
		ds_list_add(prev, [path_get_point_x(path, path_get_number(path)-1)/cs,path_get_point_y(path, path_get_number(path)-1)/cs])
	}
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
	var attempt_areas = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
	var min_distance = 100000
	var min_distance_path = path_add()
	
	for (var i=0; i<8; i++) {
		var rel_x = array_get(attempt_areas[i], 0)
		var rel_y = array_get(attempt_areas[i], 1)
		var new_goal_cell_x = goal_cell_x+rel_x
		var new_goal_cell_y = goal_cell_y+rel_y
		
		var got_path = path_add()
		path = got_path
		path_set_closed(path, false)
		
		// If place is free, attempt to get a valid path
		if mp_grid_get_cell(grid, new_goal_cell_x, new_goal_cell_y) == 0 {
			mp_grid_path(grid, got_path, x, y, new_goal_cell_x*cs, new_goal_cell_y*cs, true)
			
			var distance = path_get_length(round_path(got_path))
			if distance < min_distance {
				min_distance_path = round_path(got_path)
				min_distance = distance
			}
		}
	}
	
	if min_distance_path {
		// Mark the end position as blocked
		mp_grid_add_cell(grid, path_get_point_x(min_distance_path, path_get_number(min_distance_path)-1), path_get_point_y(min_distance_path, path_get_number(min_distance_path)-1))
					
		// Round the path values and start
		path = min_distance_path
		path_set_closed(path, false)
		path_start(path, base_path_speed*Manager.timescale, 0, true)
				
		// Clean up previous positions
		for (var j=0; j<ds_list_size(prev); j++) {
			var coords = ds_list_find_value(prev,j)
			mp_grid_clear_cell(grid, coords[0], coords[1])
		}
	}
}

// For debugging
if Manager.debug {
	for (var pix=0; pix<path_get_number(path); pix++) {
		var marker = instance_create_layer(path_get_point_x(path,pix),path_get_point_y(path,pix),layer,Marker)
		marker.image_index = (pix % 2)
		marker.image_speed = 0
		marker.instance = self                           
	}
}