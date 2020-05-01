/// @desc Add an item to the work queue.
/// @arg task Task type

var task = argument0

if !controllable { return }

if task == "WAR" {
	ds_priority_add(tasks, task, 1000)
} else {
	ds_priority_add(tasks, task, 100)
}

reset_resource_claims()