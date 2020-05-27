function refresh_grid() {
	with Manager {
		grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)
		mp_grid_add_instances(grid, Block, false)
		mp_grid_add_instances(grid, PassThrough, false)	
	}


}
