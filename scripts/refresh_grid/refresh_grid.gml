Manager.grid = mp_grid_create(0,0,room_width/Manager.cellsize,room_height/Manager.cellsize,Manager.cellsize,Manager.cellsize)
mp_grid_add_instances(Manager.grid, Block, false)
mp_grid_add_instances(Manager.grid, PassThrough, false)