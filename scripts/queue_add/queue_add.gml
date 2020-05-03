/// @desc Add an item to the work queue.
/// @arg task Task type

var task = argument0

if !controllable { return }

if task == "DRAFT" {
	ds_priority_add(tasks, task, 1000)
	reset_resource_claims()
	move_to(x,y)
} else {
	ds_priority_add(tasks, task, 100)
}