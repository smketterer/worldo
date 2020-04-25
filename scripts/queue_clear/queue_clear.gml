ds_priority_clear(tasks)

var instance = self
with Resource {
	if claimed_by == instance {
		claimed = false
		claimed_by = noone
	}
}