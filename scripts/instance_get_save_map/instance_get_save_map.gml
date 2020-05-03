///@desc Returns a map representing an instance. See GMWolf saving tutorial on Youtube.
///@param instance
///@param parent_mode

var instance = argument[0]
var variable_array = global.save_map[?instance.object_index]
var map = ds_map_create()

map[?"object_index"] = instance.object_index
map[?"layer"] = instance.layer

for (var i=0; i<array_length_1d(variable_array); i++) {
	var key = variable_array[i]
	var value = variable_instance_get(instance, key)
	map[?key] = value
}

return map