if !target or !instance_exists(target) {
	// No target, find closest enemy
	refresh_grid()
	var closest = get_closest_enemy()
	target = closest
	firing = false
	aiming = false
	
	if closest {
		var closest_direction = point_direction(x,y,closest.x,closest.y)
		var closest_distance = point_distance(x,y,closest.x,closest.y)
		
		// This works, but loop through potential fallbacks as well
		var target_location_x = lengthdir_x(closest_distance - (closest_distance*3 / 4), closest_direction)
		var target_location_y = lengthdir_y(closest_distance - (closest_distance*3 / 4), closest_direction)
		
		var closest_path = move_to(x+target_location_x, y+target_location_y)
		if !closest_path {
			// Meet in the middle
			target_location_x = lengthdir_x((closest_distance/2), closest_direction)
			target_location_y = lengthdir_y((closest_distance/2), closest_direction)
			move_to(x+target_location_x, y+target_location_y)
			var instance = self
			with closest {
				var closest_direction = point_direction(x,y,instance.x,instance.y)
				var closest_distance = point_distance(x,y,instance.x,instance.y)
				var target_location_x = lengthdir_x((closest_distance/2), closest_direction)
				var target_location_y = lengthdir_y((closest_distance/2), closest_direction)
				move_to(x+target_location_x, y+target_location_y)
			}
		}
	} else {
		// No enemies left, cancel
		queue_pop()
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