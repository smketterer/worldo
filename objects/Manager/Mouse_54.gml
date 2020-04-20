var cellsize = 16
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)

for (var i=0; i<ds_list_size(selected); i++) {
	var instance = ds_list_find_value(selected, i)
	if not object_is_ancestor(instance.object_index, Movable) {
		continue
	}
	mp_grid_add_instances(Manager.grid, Block, false)
	mp_grid_add_instances(Manager.grid, Lamp, false)
	
	with (Entity) {
		if selected == false {
			mp_grid_add_cell(Manager.grid, floor(x/cellsize), floor(y/cellsize))
		}
	}
	
	var goal_cell_x = floor(mouse_x/cellsize)
	var goal_cell_y = floor(mouse_y/cellsize)
	var goal_x = goal_cell_x * cellsize
	var goal_y = goal_cell_y * cellsize
	
	var got_path = mp_grid_path(Manager.grid, instance.path, instance.x, instance.y, goal_x, goal_y, true)
	if mp_grid_get_cell(Manager.grid, goal_cell_x, goal_cell_y) == 0 and got_path {
		mp_grid_add_cell(Manager.grid, goal_cell_x, goal_cell_y)
		with (instance) {
			path_start(path, instance.base_path_speed * Manager.timescale, 0, false)
		}
		show_debug_message(string(instance) + " clear to move to " + string(goal_cell_x) + ", " + string(goal_cell_y))
	} else {
		with (instance) {
			var solution = false
			var preferred = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
			for (var ii=0; ii<8; ii++) {
				if solution {
					continue
				}
				var placex = array_get(preferred[ii],0)
				var placey = array_get(preferred[ii],1)
				var gx = goal_cell_x + placex
				var gy = goal_cell_y + placey
				if mp_grid_get_cell(Manager.grid, gx, gy) == 0 {
					show_debug_message(string(instance) + " blocked, moving to " + string(placex) + ", " + string(placey))
					var got_path = mp_grid_path(Manager.grid, path, x, y, gx * cellsize, gy * cellsize, true)
					mp_grid_add_cell(Manager.grid, gx, gy)
					if got_path {
						path_start(path, instance.base_path_speed * Manager.timescale, 0, false)
						solution = true
					}
				} else {
					show_debug_message(string(instance) + " can't move to " + string(placex) + ", " + string(placey))
				}
			}
		}
	}
}