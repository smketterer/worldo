size = ds_list_size(selected)
for (var i=0; i<size; i++) {
	with ds_list_find_value(selected, i) {
		instance_destroy()
	}
}