var instance = self
var resource = noone

with Resource {
	if claimed_by == instance {
		claimed = true
		claimed_by = instance
		resource = self
	}
}

if !resource and hauling == noone {
	// No resource, find closest unclaimed bush
	refresh_grid()
	var closest = get_closest_unclaimed_resource(Storable, true)
	if closest {
		move_to(closest.x, closest.y)
		closest.claimed = true
		closest.claimed_by = self
	} else {
		// No resources left, cancel
		queue_pop()
	}
} else if hauling == noone {
	// Next to resource, carry it.
	if path_position == 1 {
		resource.lifted -= ((hauling_skill / 10) * Manager.timescale)
		
		if resource.lifted <= 0 {
			var closest = get_closest_unclaimed_resource(Zone)
			if closest {
				move_to(closest.x, closest.y)
				closest.claimed = true
				closest.claimed_by = self
			} else {
				// No resources left, cancel
				queue_pop()
			}
		}
	}
} else {
	// Is hauling item, place in stockpile
	hauling.x = x
	hauling.y = y
	
	if path_position == 1 {
		resource.stored = true
		reset_resource_claims()
	}
}