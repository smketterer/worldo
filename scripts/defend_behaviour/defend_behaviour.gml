if !target or !instance_exists(target) {
	// No target, find closest enemy
	refresh_grid()
	var closest = get_closest_enemy()
	target = closest
	if closest {
		var closest_direction = point_direction(x,y,closest.x,closest.y)
		var closest_distance = point_distance(x,y,closest.x,closest.y)
		var target_location_x = lengthdir_x(closest_distance - 128, closest_direction)
		var target_location_y = lengthdir_y(closest_distance - 128, closest_direction)
		move_to(x+target_location_x, y+target_location_y)
	} else {
		// No enemies left, cancel
		queue_pop()
		aiming = false
		target = noone
		if dir == 1 {
			direction = 0
			aim_dir = direction
		} else {
			direction = 180
			aim_dir = direction
		}
	}
} else {
	// Check whether you're close enough to fire.
	if path_position == 1 {
		aiming = true
		if attack_counter > 0 {
			firing = false
			attack_counter -= Manager.timescale
		} else {
			firing = true
			attack_counter = attack_cooldown
		}
	}
}