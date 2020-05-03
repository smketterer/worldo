if active {
	image_index = 1
} else {
	image_index = 0
}
draw_sprite(sprite_index,image_index,x,y)

if active {
	draw_set_alpha(.25)
}
draw_set_halign(fa_center)
draw_text(x+(sprite_width/2),y+active,text)
draw_set_halign(fa_left)
draw_set_alpha(1)