randomize()
selected = ds_list_create()
cellsize = 16
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)
mp_grid_add_instances(Manager.grid, Block, false)

window_set_fullscreen(true)
draw_set_font(font0)
