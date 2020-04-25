/// @desc Remove the top item in the work queue.

ds_priority_delete_max(tasks)

var instance = self
with Resource {
	if claimed_by == instance {
		claimed = false
		claimed_by = noone
	}
}