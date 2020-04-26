event_inherited()

if claimed_by == noone and !claimed {
	lifted = to_lift
	x = floor(x/Manager.cellsize)*Manager.cellsize
	y = floor(y/Manager.cellsize)*Manager.cellsize
}

if lifted <= 0 {
	if (claimed_by) {
		layer_add_instance(claimed_by.layer, self)
		claimed_by.hauling = self
	}
}

if !place_meeting(x,y,Zone) {
	stored = false	
}