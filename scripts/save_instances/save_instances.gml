///@desc Returns a JSON string of all instances.

var list = ds_list_create()

with (all) {
	if (ds_map_exists(global.save_map, object_index)) {
		// Exists in map, save.
		var map = instance_get_save_map(id)
		ds_list_add(list, map)
		ds_list_mark_as_map(list, ds_list_size(list)-1) // Mark it for serialization
	}
}

var m = ds_map_create()
ds_map_add_list(m, "instances", list)
var json = json_encode(m)

ds_map_destroy(m)

return json