function queue_contains(argument0) {
	var contains = ds_priority_find_priority(tasks, argument0)
	if !is_undefined(contains) {
		// return contains
		return true
	} else {
		return false
	}



}
