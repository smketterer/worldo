var path = argument0

for (var pix=0; pix<path_get_length(path); pix++) {
	round_x = floor(path_get_point_x(path,pix) / 16) * 16
	round_y = floor(path_get_point_y(path,pix) / 16) * 16
	path_change_point(path, pix, round_x, round_y, 100)                                     
}
path_insert_point(path, 0, x, y, 100)

return path