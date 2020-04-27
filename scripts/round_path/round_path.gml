var path = argument0

for (var pix=0; pix<path_get_number(path); pix++) {
	round_x = floor(path_get_point_x(path,pix) / Manager.cellsize) * Manager.cellsize
	round_y = floor(path_get_point_y(path,pix) / Manager.cellsize) * Manager.cellsize
	path_change_point(path, pix, round_x, round_y, 100)                                     
}
path_insert_point(path, 0, x, y, 100)

return path