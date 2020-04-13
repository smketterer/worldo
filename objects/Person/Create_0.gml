event_inherited()

draw_y = y
dir = 1
move_length = 0
current_xscale = 1

rand = random(1)
if rand > .75 {
	sprite_index = char0
} else if rand > .5 {
	sprite_index = char1
} else if rand > .25 {
	sprite_index = char2
} else {
	sprite_index = char3
}

rand = random(1)
if rand > .5 {
	hands_sprite_index = handsNone
} else {
	hands_sprite_index = handsRifle
}