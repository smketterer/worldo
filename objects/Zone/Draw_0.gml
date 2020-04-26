event_inherited()

if claimed {
	draw_set_color(c_lime)
} else {
	draw_set_color(c_red)
}
draw_set_alpha(.2)
draw_rectangle(x,y,x+Manager.cellsize,y+Manager.cellsize,false)
draw_set_color(c_white)
draw_set_alpha(1)