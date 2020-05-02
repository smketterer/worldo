if !target or !instance_exists(target) or path_get_number(path) <= 2 {
	// No target, find closest enemy
	refresh_grid()
	var closest = get_closest_enemy()
	target = closest
	firing = false
	aiming = false
	
	if closest {
		var closest_end_x = x
		var closest_end_y = x
		
		// Move to end of closest path
		if (closest.path) {
			closest_end_x = path_get_point_x(closest.path,path_get_number(closest.path)-1)
			closest_end_y = path_get_point_y(closest.path,path_get_number(closest.path)-1)
		}

		var closest_direction = point_direction(x,y,closest.x,closest.y)
		var closest_distance = point_distance(x,y,closest.x,closest.y)
		var distances = [3/4, 1/2, 1/4, 0]
		
		for (var i=0; i<array_length_1d(distances); i++) {
			var to_x = lengthdir_x(closest_distance + (closest_distance*-distances[i]), closest_direction)
			var to_y = lengthdir_y(closest_distance + (closest_distance*-distances[i]), closest_direction)
			move_to(x+to_x, y+to_y)
			
			if path and !collision_line(x+to_x, y+to_y, target.x, target.y, Block, true, true) {
				break
			}
		}
	} else {
		// No enemies left, cancel
		queue_pop()
		target = noone
		move_to(x,y)
		
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
	if path and path_position == 1 {
		if collision_line(x,y,target.x,target.y,Block,true,true) {
			target = noone
		}
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