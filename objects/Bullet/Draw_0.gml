ds_list_add(draw_buffer,[x,y])

var xx = xprevious
var yy = yprevious
var count = 0

z -= lengthdir_y(speed,zdir)

while (point_distance(x,y,xx,yy) >= 1) {
	var meeting = instance_position(xx,yy,Entity)
	if meeting and meeting != creator {
		with meeting {
			if variable_instance_exists(id,"hp") {
				hp -= 10
			}
		}
		instance_destroy()
		return
	}
	if (z <= 0) {
		instance_create_layer(x,y,layer,bulletHitFloor)
		instance_destroy()
	}
	var factor = ((count-(speed/4))/speed)
	if count > speed/4 {
		draw_sprite_ext(sprite_index,image_index,xx,yy-z+10,factor+.5,factor+.5,image_angle,image_blend,factor)
	}
	xx += lengthdir_x(1,point_direction(xx,yy,x,y))
	yy += lengthdir_y(1,point_direction(xx,yy,x,y))
	count++
}

draw_sprite_ext(bullet1,image_index,x,y+10,image_xscale,image_yscale,direction,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x,y-z+10,image_xscale,image_yscale,image_angle,image_blend,image_alpha)