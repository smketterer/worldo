event_inherited()

draw_y = y
dir = 1
ydir = 0
move_length = 0
current_xscale = 1

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
if rand > .5 {
	hands_sprite_index = handsNone
} else {
	hands_sprite_index = handsRifle
}
