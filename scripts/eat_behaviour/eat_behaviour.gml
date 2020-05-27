function eat_behaviour() {
	var instance = self
	var resource = noone
	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			resource = self
		}
	}
	if !resource {
		// No resource, find closest unclaimed tree
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Berries)
		if closest {
			move_to(closest.x, closest.y)
			closest.claimed = true
			closest.claimed_by = self
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else {
		// Next to berries, eat them.
		if path_position == 1 {
			resource.hp -= (.25 * Manager.timescale)
			hunger += (.25 * resource.nutrition * Manager.timescale)
			hauling = resource
			hauling.x = x
			hauling.y = y
		
			if hunger >= 100 {
				// drop current food, stop eating
				var zone = instance_place(x,y,Zone)
				reset_resource_claims()
				if (zone) {
					zone.claimed = true
					zone.claimed_by = resource
				}
				queue_pop()
			}
		}
	}


}
