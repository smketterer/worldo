if active {
	draw_set_colour(c_black)
} else {
	draw_set_colour(make_color_rgb(7,7,8))
}
draw_rectangle(2,(window_get_height()-Manager.tab_height)+(22*i)+22,Manager.tab_width-2,(window_get_height()-Manager.tab_height)+(22*i)+44,false)
draw_set_colour(c_black)
draw_rectangle(2,(window_get_height()-Manager.tab_height)+(22*i)+22,Manager.tab_width-2,(window_get_height()-Manager.tab_height)+(22*i)+44,true)
if active {
	draw_set_alpha(.25)
}
draw_set_colour(make_color_rgb(20,20,20))
draw_line(3,(window_get_height()-Manager.tab_height)+(22*i)+22+1,Manager.tab_width-3,(window_get_height()-Manager.tab_height)+(22*i)+22+1)
draw_set_colour(c_white)
draw_text(3+40,(window_get_height()-Manager.tab_height)+(22*i)+22+4,text)
var sprite = object_get_sprite(item)
draw_sprite(sprite,image_index,3+20-(sprite_get_width(sprite)/2),(window_get_height()-Manager.tab_height)+(22*i)+22+4)
draw_set_alpha(1)
