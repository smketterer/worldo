var top_meeting = place_meeting(x,y-1,object_index);
var bottom_meeting = place_meeting(x,y+1,object_index);
var right_meeting = place_meeting(x+1,y,object_index);
var left_meeting = place_meeting(x-1,y,object_index);

var w = sprite_width
var h = w

if top_meeting && bottom_meeting && right_meeting && left_meeting {
	draw_sprite_part_ext(tileset,image_index,w*2,0,w,h,x,y,facing,image_yscale,image_blend,1)
	return
}
if bottom_meeting && right_meeting {
	draw_sprite_part_ext(tileset,image_index,0,0,w,h,x,y,facing,image_yscale,image_blend,1)
	return
}
if bottom_meeting && left_meeting {
	facing = -1
	draw_sprite_part_ext(tileset,image_index,0,0,w,h,x+w,y,facing,image_yscale,image_blend,1)
	return
}

if bottom_meeting && top_meeting {
	if instance_place(x,y-1,object_index).facing == 1 {
		draw_sprite_part_ext(tileset,image_index,0,h,w,h,x,y,facing,image_yscale,image_blend,1)
		return
	} else {
		facing = -1
		draw_sprite_part_ext(tileset,image_index,0,h,w,h,x+w,y,facing,image_yscale,image_blend,1)
		return
	}
}

if top_meeting && right_meeting {
	draw_sprite_part_ext(tileset,image_index,0,h*2,w,h,x,y,facing,image_yscale,image_blend,1)
	return
}

if top_meeting && left_meeting {
	facing = -1
	draw_sprite_part_ext(tileset,image_index,0,h*2,w,h,x+w,y,facing,image_yscale,image_blend,1)
	return
}

if top_meeting {
	if instance_place(x,y-1,object_index).facing == 1 {
		draw_sprite_part_ext(tileset,image_index,w,h*2,w,h,x,y,facing,image_yscale,image_blend,1)
		return
	} else {
		facing = -1
		draw_sprite_part_ext(tileset,image_index,w,h*2,w,h,x+w,y,facing,image_yscale,image_blend,1)
		return
	}
	return
}

if bottom_meeting {
	if instance_place(x,y+1,object_index).facing == 1 {
		draw_sprite_part_ext(tileset,image_index,w,h*1,w,h,x,y,facing,image_yscale,image_blend,1)
		return
	} else {
		facing = -1
		draw_sprite_part_ext(tileset,image_index,w,h*1,w,h,x+w,y,facing,image_yscale,image_blend,1)
		return
	}
	return
}

draw_sprite_part_ext(tileset,image_index,w,0,w,h,x,y,image_xscale,image_yscale,image_blend,1)