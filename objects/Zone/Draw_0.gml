event_inherited()

if claimed {
	draw_set_color(c_lime)
} else {
	draw_set_color(c_red)
}
draw_set_alpha(.2)
draw_rectangle(x,y,x+Manager.cellsize-1,y+Manager.cellsize-1,false)
draw_set_color(c_white)
draw_set_alpha(1)