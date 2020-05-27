function reset_resource_claims() {
	var instance = self
	with Resource {
		if claimed_by == instance {
			claimed = false
			claimed_by = noone
		}
	}
	with hauling {
		var newinst = instance_copy(false)
		layer_add_instance(initial_layer, newinst)
		newinst.polygon = polygon_from_instance(newinst.id)
		newinst.shadow_length = 0
		newinst.selected = false
		instance_destroy()
	}
	hauling = noone
	path = path_add()



}
