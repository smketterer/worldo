event_inherited()

if !aiming {
	aim_dir = direction
}

if path_get_number(path) > 0 and path_position < 1 and Manager.timescale > 0 {
	moving = true
	move_length += 1
	if (direction < 90 or direction > 270) {
		dir = 1
	} else {
		dir = -1
	}
	if (direction > 0 and direction < 180) {
		ydir = 1
	} else {
		ydir = 0
	}
} else {
	moving = false
	move_length = 0
}

if aiming and target and instance_exists(target) {
	if (x < target.x) {
		dir = 1
	} else if (x >= target.x) {
		dir = -1
	}
	if (y <= target.y) {
		ydir = 0
	} else if (y > target.y) {
		ydir = 1
	}
	aim_dir = point_direction(x,y,target.x,target.y)
}

if firing {
	var bullet = instance_create_layer(barrel_x,barrel_y,"Overlays",Bullet)	
	var shot_variance = 35 / shooting_skill
	bullet.direction = aim_dir + (random(shot_variance) - (shot_variance / 2))
	bullet.zdir = (random(shot_variance) - (shot_variance / 2))/2
	bullet.speed = bullet.base_bullet_speed * Manager.timescale
	bullet.creator = self
}