// Needs base
hungry = 100
tired = 100
isolated = 100

// Drawing
draw_y = y
dir = 1
ydir = 0
aim_dir = direction
move_length = 0

// Shoot
current_xscale = 1
current_handsoffset = 0
firing = false
barrel_x = x
barrel_y = y

// Equip and faction stats
equip = ds_list_create()
controllable = true
faction = "player"

hands_sprite_index = handsNone
ds_list_add(equip,Shotgun)

// Generate character settings
sprite_index = char5
sex = "female"
first_name = get_name("fn_female")
nickname = get_name("nn_female")
last_name = get_name("ln")
age = floor(18 + random(80 - 18))
name = first_name + " '" + nickname + "' " + last_name

event_inherited()