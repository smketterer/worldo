/// @desc Add an item to the work queue.
/// @arg task Task type

var task = argument0
path = path_add()

if task == "WAR" {
	ds_priority_add(tasks, task, 1000)
} else {
	ds_priority_add(tasks, task, 100)
}

var instance = self
with Resource {
	if claimed_by == instance {
		claimed = false
		claimed_by = noone
	}
}