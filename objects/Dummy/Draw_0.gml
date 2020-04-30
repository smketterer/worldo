event_inherited()

if Manager.debug {
	if target {
		draw_text(x,y,string(target.name))
	}
	draw_text(x,y+8,string(firing) + "," + string(aiming))
}