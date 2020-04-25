var cellsize = Manager.cellsize
var grid = argument0

grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)
mp_grid_add_instances(Manager.grid, Block, false)

for (var i=0; i<ds_list_size(Manager.selected); i++) {
	var instance = ds_list_find_value(Manager.selected, i)
	if not instance.object_index == Person {
		continue
	}
	mp_grid_add_instances(grid, Block, false)
	mp_grid_add_instances(grid, Lamp, false)
	
	with (Entity) {
		if selected == false {
			mp_grid_add_cell(grid, floor(x/cellsize), floor(y/cellsize))
		}
	}
	
	var goal_cell_x = floor(argument1/cellsize)
	var goal_cell_y = floor(argument2/cellsize)
	var goal_x = goal_cell_x * cellsize
	var goal_y = goal_cell_y * cellsize
	
	var got_path = mp_grid_path(grid, instance.path, instance.x, instance.y, goal_x, goal_y, true)
	if mp_grid_get_cell(grid, goal_cell_x, goal_cell_y) == 0 and got_path {
		mp_grid_add_cell(grid, goal_cell_x, goal_cell_y)
		with (instance) {
			for (var pix=0; pix<path_get_length(path); pix++) {
				round_x = floor(path_get_point_x(path,pix) / 16) * 16
				round_y = floor(path_get_point_y(path,pix) / 16) * 16
				path_change_point(path, pix, round_x, round_y, 100)                                     
			}
			path_insert_point(path, 0, x, y, 100)
			path_start(path, instance.base_path_speed * Manager.timescale, 0, true)
		}
		log(string(instance) + " clear to move to " + string(goal_cell_x) + ", " + string(goal_cell_y))
	} else {
		with (instance) {
			path = path_move_close(goal_x, goal_y)
			path_start(path, base_path_speed * Manager.timescale, 0, true)
		}
	}
}

mp_grid_destroy(grid)