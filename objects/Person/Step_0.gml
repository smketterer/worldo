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

firing = mouse_check_button_pressed(mb_left)
if firing {
	var bullet = instance_create_layer(barrel_x,barrel_y,layer,Bullet)	
	var shot_variance = 35 / shooting_skill
	bullet.direction = direction + (random(shot_variance) - (shot_variance / 2))
	bullet.speed = bullet.base_bullet_speed * Manager.timescale
	bullet.creator = self
}