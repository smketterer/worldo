var instance = self
var resources = ds_list_create()
with Resource {
	if claimed_by == instance {
		claimed = true
		claimed_by = instance
		ds_list_add(resources, self)
	}
}
/*
if !resource {
	// No resource, find closest unclaimed bush
	refresh_grid()
	var closest = get_closest_unclaimed_resource(Blueprint)
	if closest {
		move_to(closest.x, closest.y)
		closest.claimed = true
		closest.claimed_by = self
	} else {
		// No resources left, cancel
		queue_pop()
	}
} else {
	// Next to resource, build it.
	if path_position == 1 {
		resource.work -= ((building_skill / 10) * Manager.timescale)
	}
}
*/


if ds_list_size(resources) == 0 and hauling == noone {
	// Get closest blueprint and required resources
	refresh_grid()
	var closest = get_closest_unclaimed_resource(Blueprint)
	
	if closest {
		refresh_grid()
		var requirement = get_closest_unclaimed_resource(closest.requirement)
		
		closest.claimed = true
		closest.claimed_by = self
		requirement.claimed = true
		requirement.claimed_by = self
		
		move_to(requirement.x, requirement.y)
	} else {
		// No resources left, cancel
		queue_pop()
	}
} else if !hauling {
	// Hauling requirement to blueprint
	for (var i=0; i<ds_list_size(resources); i++) {
		var resource = ds_list_find_value(resources,i)
		if resource.object_index != Blueprint {
			if path_position == 1 {
				resource.work -= ((hauling_skill / 10) * Manager.timescale)
				if resource.work <= 0 {
					for (var i=0; i<ds_list_size(resources); i++) {
						var resource2 = ds_list_find_value(resources,i)
						if resource2.object_index == Blueprint {
							hauling_to = [resource2.x, resource2.y]
							move_to(resource2.x, resource2.y)
						}
					}
				}
			}
		}
	}
} else if hauling {
	// Is hauling item, place on blueprint and begin work
	hauling.x = x
	hauling.y = y
	
	if path_position == 1 {
		// Place resources
		var placed_resource = noone
		for (var i=0; i<ds_list_size(resources); i++) {
			var resource = ds_list_find_value(resources,i)
			if resource.object_index != Blueprint {
				placed_resource = resource
				resource.stored = true
				hauling.x = hauling_to[0]
				hauling.y = hauling_to[1]
			}
		}
		// Next to resource, build it.
		if path_position == 1 {
			resource.work -= ((building_skill / 10) * Manager.timescale)
			if resource.work <= 0 {
				with placed_resource {
					instance_destroy()
				}
				reset_resource_claims()
			}
		}
	}
}