var instance = self
with Resource {
	if claimed_by == instance {
		claimed = false
		claimed_by = noone
	}
}
with hauling {
	layer_add_instance(initial_layer, self)
}
hauling = noone