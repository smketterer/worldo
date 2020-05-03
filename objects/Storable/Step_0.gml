event_inherited()

if claimed_by == noone and !claimed {
	work = to_lift
	x = floor(x/Manager.cellsize)*Manager.cellsize
	y = floor(y/Manager.cellsize)*Manager.cellsize
}

if work <= 0 {
	if (claimed_by) {
		var newinst = instance_copy(false)
		layer_add_instance(claimed_by.layer, newinst)
		newinst.selected = false
		instance_destroy()
		claimed_by.hauling = newinst
	}
}

if !place_meeting(x,y,Zone) {
	stored = false	
}