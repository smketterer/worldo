event_inherited()

if Manager.debug {
	if target {
		draw_text(x,y,string(target.nickname))
	}
	draw_text(x,y+8,string(firing) + "," + string(aiming))
	draw_text(x,y+16,string(path_get_number(path)) + "," + string(id))
}