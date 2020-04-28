event_inherited()

draw_y = y
dir = 1
ydir = 0
aim_dir = direction
move_length = 0

current_xscale = 1
current_handsoffset = 0
firing = false
barrel_x = x
barrel_y = y

controllable = true

faction = "player"

rand = random(1)
if rand > .8 {
	sprite_index = char0
	first_name = get_name("fn_male")
	nickname = get_name("nn_male")
} else if rand > .6 {
	sprite_index = char2
	first_name = get_name("fn_male")
	nickname = get_name("nn_male")
} else if rand > .4 {
	sprite_index = char1
	first_name = get_name("fn_female")
	nickname = get_name("nn_female")
} else if rand > .2 {
	sprite_index = char3
	first_name = get_name("fn_female")
	nickname = get_name("nn_female")
} else {
	sprite_index = char5
	first_name = get_name("fn_female")
	nickname = get_name("nn_female")
}
last_name = get_name("ln")
name = first_name + " '" + nickname + "' " + last_name

rand = random(1)
if rand > .95 {
	hands_sprite_index = handsNone
} else {
	hands_sprite_index = handsShotgun
}