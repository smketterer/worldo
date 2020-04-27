ds_list_add(draw_buffer,[x,y])

var xx = xprevious
var yy = yprevious
var count = 0

while (point_distance(x,y,xx,yy) >= 1) {
	if !place_empty(xx,yy,Entity,Block) {
		if other != creator {
			with other {
				if variable_instance_exists(id,"hp") {
					hp -= 10
				}
			}
			instance_destroy()
			return
		}
	}
	var factor = ((count-(speed/2))/speed)
	if count > speed/2 {
		draw_sprite_ext(sprite_index,image_index,xx,yy,factor+.5,factor+.5,image_angle,image_blend,factor)
	}
	xx += lengthdir_x(1,point_direction(xx,yy,x,y))
	yy += lengthdir_y(1,point_direction(xx,yy,x,y))
	count++
}

draw_sprite_ext(bullet1,image_index,x,y+z,image_xscale,image_yscale,direction,image_blend,image_alpha)
draw_self()