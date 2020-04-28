// var instance = self
// var resource = noone

if !target {
	// No target, find closest enemy
	refresh_grid()
	var closest = get_closest_enemy()
	target = closest
	if closest {
		move_to(closest.x, closest.y)
	} else {
		// No enemies left, cancel
		queue_pop()
	}
} else {
	// Check whether you're close enough to fire.
	if path_get_number(path) > 0 {
		if !collision_line(x,y,target.x,target.y,Block,true,true) and point_distance(x,y,target.x,target.y) < 320 {
			// Can fire. Stop ASAP.
			path_end()
			path = path_add()
		}
	} else {
		aiming = true
		if attack_counter > 0 {
			firing = false
			attack_counter -= Manager.timescale
		} else {
			firing = true
			attack_counter = attack_cooldown
		}
	}
	
	if aiming and point_distance(x,y,target.x,target.y) > 320 {
		// recalculate path
	}
}