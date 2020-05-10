for (var i=0; i<array_length_1d(task_order); i++) {
	if can_perform(task_order[i]) {
		ds_priority_add(tasks, task_order[i], 100)
	}
}