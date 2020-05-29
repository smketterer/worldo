/// @desc Add an item to the work queue.
/// @arg task Task type

function queue_add(_task) {
	if !controllable { exit }

	if _task == "DRAFT" {
		ds_priority_add(tasks, _task, 1000)
		reset_resource_claims()
		move_to(x,y)
	} else {
		ds_priority_add(tasks, _task, 100)
	}	
}

function queue_contains(_task) {
	var contains = ds_priority_find_priority(tasks, _task)
	if !is_undefined(contains) {
		// return contains
		return true
	} else {
		return false
	}
}

/// @desc Remove the top item in the work queue.
function queue_pop() {
	ds_priority_delete_max(tasks)
	evaluate_needs()
	reset_resource_claims()
}

/// @desc Get labels for tasks from task value.
/// @arg task
function get_task_label(_task) {
	switch (_task) {
		case "DEFEND":
			return "Defending the base"
		case "DRAFT":
			return "Drafted"
		case "CHOP":
			return "Chopping wood"
		case "CUT":
			return "Foraging"
		case "HAUL":
			return "Hauling items"
		case "BUILD":
			return "Building items"
		case "EAT":
			return "Looking for food"
		default:
			return "Idle"
	}
}
