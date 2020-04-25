/// @desc Add an item to the work queue.
/// @arg task Task type

var task = argument0
path = path_add()

if task == "WAR" {
	ds_priority_add(tasks, task, 1000)
} else if task == "CHOP" {
	ds_priority_add(tasks, task, 100)
	path = path_add()
	var closest_tree = get_closest_unclaimed_resource(Tree)
	path = get_close(closest_tree.x, closest_tree.y)
	if (path) {
		closest_tree.claimed = true
		closest_tree.claimed_by = self
		path_start(path, base_path_speed * Manager.timescale, 0, true)
	}
}