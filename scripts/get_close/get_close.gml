var to_x = argument0
var to_y = argument1

var goal_cell_x = floor(to_x/Manager.cellsize)
var goal_cell_y = floor(to_y/Manager.cellsize)

var preferred = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
var path = path_add()

for (var ii=0; ii<8; ii++) {
	var placex = array_get(preferred[ii],0)
	var placey = array_get(preferred[ii],1)
	var gx = goal_cell_x + placex
	var gy = goal_cell_y + placey
	if mp_grid_get_cell(Manager.grid, gx, gy) == 0 {
		var got_path = mp_grid_path(Manager.grid, path, self.x, self.y, gx * Manager.cellsize, gy * Manager.cellsize, true)
		if got_path {
			mp_grid_add_cell(Manager.grid, gx, gy)
			for (var pixy=0; pixy<path_get_length(path); pixy++) {
				var round_x = floor(path_get_point_x(path,pixy) / 16) * 16
				var round_y = floor(path_get_point_y(path,pixy) / 16) * 16
				path_change_point(path, pixy, round_x, round_y, 100)                                     
			}
			path_insert_point(path, 0, self.x, self.y, 100)
			return path
		}
	}
}