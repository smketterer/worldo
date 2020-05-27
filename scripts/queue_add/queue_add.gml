/// @desc Add an item to the work queue.
/// @arg task Task type

function queue_add() {
	if !controllable { exit }

	if task == "DRAFT" {
		ds_priority_add(tasks, task, 1000)
		reset_resource_claims()
		move_to(x,y)
	} else {
		ds_priority_add(tasks, task, 100)
	}	
}