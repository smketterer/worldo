event_inherited()

if path_get_length(path) > 0 and path_position < 1 {
	moving = true
	move_length += 1
	if direction < 90 or direction > 270 {
		dir = 1
	} else {
		dir = -1
	}
} else {
	moving = false
	move_length = 0
}