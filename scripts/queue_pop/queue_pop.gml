/// @desc Remove the top item in the work queue.
function queue_pop() {
	ds_priority_delete_max(tasks)

	evaluate_needs()
	reset_resource_claims()
}
