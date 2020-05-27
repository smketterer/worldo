function round_path(argument0) {
	var path = argument0

	for (var pix=0; pix<path_get_number(path); pix++) {
		var cell_x = floor(path_get_point_x(path,pix) / Manager.cellsize)
		var cell_y = floor(path_get_point_y(path,pix) / Manager.cellsize)
		var round_x = cell_x * Manager.cellsize
		var round_y = cell_y * Manager.cellsize

		/*
		var marker = instance_create_layer(round_x,round_y,layer,Marker)
		marker.image_index = (pix % 2)
		marker.image_speed = 0
		marker.instance = self
		*/
	
		path_change_point(path, pix, round_x, round_y, 100)
	}
	path_insert_point(path, 0, x, y, 100)

	return path


}
