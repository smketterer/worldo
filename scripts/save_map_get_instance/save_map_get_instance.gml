///@desc Create an instance from the save map.
///@param map

var map = argument0
var object = map[?"object_index"]
var _layer = map[?"layer"]

var instance = instance_create_layer(0, 0, _layer, object)

var variable_array = global.save_map[?instance.object_index]

for (var i=0; i<array_length_1d(variable_array); i++) {
	var key = variable_array[i]
	var value = map[?key]
	
	variable_instance_set(instance, key, value)
}

return instance