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
	var closest = get_closest_unclaimed_resource(Tree)
	if closest {
		move_to(closest.x, closest.y)
		closest.claimed = true
		closest.claimed_by = self
	} else {
		// No resources left, cancel
		queue_pop()
	}
} else {
	// Next to tree, cut it.
	if path_position == 1 {
		resource.hp -= ((chopping_skill / 10) * Manager.timescale)
	}
}