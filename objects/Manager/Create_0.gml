randomize()

selected = ds_list_create()
cellsize = 16

// Pathfinding
grid = mp_grid_create(0,0,room_width/cellsize,room_height/cellsize,cellsize,cellsize)
mp_grid_add_instances(Manager.grid, Block, false)
mp_grid_add_instances(Manager.grid, PassThrough, false)

draw_set_font(font0)

#region console
debug = false
txr_init()
console = ds_list_create()
th = txr_thread_create(txr_compile(""))
log("# Debug console")
caret_flash = 0
caret_flash_rate = 15
caret_move = 0
caret_move_rate = 7
text = "" // current text
caret = 0 // caret position
fillchar = "`" // used as filler character in input handling.
filltext = string_repeat(fillchar, 10)
#endregion

#region Time
prev_timescale = 0
timescale = 1
#endregion

#region Lighting init
lighting_global()
tick = 0;
dirty = false;
#endregion

#region Day and night cycle
seconds = 60 * 60 * 10
minutes = 0
hours = 0

day = 1
season = 1
year = 1

phase = [[0,merge_colour(c_navy,c_black,.2),.7],[6,merge_colour(c_navy,c_black,.2),.7],[8,c_orange,.2],[12,merge_colour(c_white,c_yellow,.5),0.1],[16,merge_colour(c_white,c_yellow,.5),0.1],[18,c_red,.25],[22,merge_colour(c_navy,c_black,.3),.7],[24,merge_colour(c_navy,c_black,.2),.7]] // time, colour, darkness
current_colour = array_get(phase[0],1)
current_darkness = array_get(phase[0],2)
#endregion

#region GUI
// UI
cursor_mode = "select"
active_panel = "none"
tab_height = 256
tab_width = 191
active_blueprint = noone
inspecting = noone

var i = 0
var tab = instance_create_layer(0,window_get_height()-16,"Overlays",Tab)
tab.text = "Orders"
tab.script = tab_orders
i++

var tab = instance_create_layer(0+(64*i),window_get_height()-16,"Overlays",Tab)
tab.text = "Build"
tab.script = tab_build
i++

var tab = instance_create_layer(0+(64*i),window_get_height()-16,"Overlays",Tab)
tab.text = "Zone"
tab.script = tab_zone
i++

var tab = instance_create_layer(0+(64*i),window_get_height()-16,"Overlays",Tab)
tab.text = "Animals"
i++

var tab = instance_create_layer(0+(64*i),window_get_height()-16,"Overlays",Tab)
tab.text = "World"
i++
#endregion