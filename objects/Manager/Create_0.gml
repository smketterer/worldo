randomize()
selected = ds_list_create()
cellsize = 16
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)
mp_grid_add_instances(Manager.grid, Block, false)
mp_grid_add_instances(Manager.grid, PassThrough, false)

// window_set_fullscreen(true)
draw_set_font(font0)

timescale = 1

#region Lighting init
lighting_global();
tick = 0;
dirty = false;
#endregion

#region Day and night cycle
seconds = 60 * 60 * 12
minutes = 0
hours = 0

day = 1
season = 1
year = 1

phase = [[0,merge_colour(c_navy,c_black,.2),.7],[6,merge_colour(c_navy,c_black,.2),.7],[8,c_orange,.2],[12,c_white,0],[16,c_white,0],[18,c_red,.25],[22,merge_colour(c_navy,c_black,.3),.7],[24,merge_colour(c_navy,c_black,.2),.7]] // time, colour, darkness
current_colour = array_get(phase[0],1)
current_darkness = array_get(phase[0],2)
#endregion
