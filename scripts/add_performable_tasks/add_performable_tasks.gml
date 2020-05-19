for (var i=0; i<ds_list_size(task_order); i++) {
	if can_perform(ds_list_find_value(task_order,i)) {
		ds_priority_add(tasks, ds_list_find_value(task_order,i), 100)
	}
}