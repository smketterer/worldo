event_inherited()

if path_get_number(path) > 0 and path_position < 1 and Manager.timescale > 0 {
	moving = true
	move_length += 1
	if direction < 90 or direction > 270 {
		dir = 1
	} else {
		dir = -1
	}
	if direction > 0 and direction < 180 {
		ydir = 1
	} else {
		ydir = 0
	}
} else {
	moving = false
	move_length = 0
}